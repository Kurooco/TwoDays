extends Node2D

@export var platform : PackedScene
@export var pole : PackedScene
@export var worldmap : Node
@export var coins : PackedScene
var taken_spots = {}
var direction_map = {0: Vector2.UP, 1: Vector2.RIGHT, 2: Vector2.DOWN, 3: Vector2.LEFT}
var target_position = null
var placed = 0
var coins_placed
var currently_saving = false
var already_placed_verticle = false

var restart_directions = []
var restart_coins = []

const GRID_WIDTH = 50
const GRID_HEIGHT = 50
var grid_border
const STARTING_AMOUNT = 2000 #2000
const COIN_SEPERATION = 300 #400

# Called when the node enters the scene tree for the first time.
func _ready():
	coins_placed = []
	grid_border = $"/root/Autoload".border*2
	currently_saving = true
	if(Autoload.prev_builder != null && Autoload.retrying):
		restart(Autoload.prev_builder)
		Autoload.prev_builder = self
		Autoload.retrying = false
	else:
		Autoload.prev_builder = self
		#get_viewport_rect().size*2
		move_and_place(1)
		
		while placed < STARTING_AMOUNT: 
			var prev = placed
			move_random_and_place_climbable()
			var coin_close = false
			for i in coins_placed:
				if(position.distance_to(i.position) < COIN_SEPERATION):
					coin_close = true
					break
			if(!coin_close && position.distance_to(Vector2.ZERO) < 2000):
				coins_placed.append(place_coin())
		$"/root/Autoload".coins = coins_placed.size()
	currently_saving = false

func restart(prev_builder):
	# Replace structure
	for i in prev_builder.restart_directions:
		move_and_place(i)
	
	# Replace coins
	for i in prev_builder.restart_coins:
		global_position = i
		coins_placed.append(place_coin())
	Autoload.coins = coins_placed.size()
	print_debug(coins_placed.size())
	print_debug(Autoload.coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print_debug(Autoload.coins)
	await get_tree().process_frame
	if(Input.is_action_just_pressed("call builder") && Autoload.can_target):
		target_position = get_global_mouse_position()
		$"../Target".global_position = target_position
		#$CanvasLayer/Target.global_position = target_position/4 + (grid_border)/2
		$"../Target".focus()
		$"../Target".show()

func move_and_place(dir):
	var direction = move(dir)
	
	# Check to make sure this spot is not occupied
	var placement_position = global_position + (direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)/-2)
	if(taken_spots.has(placement_position) && is_instance_valid(taken_spots[placement_position]) && !taken_spots[placement_position].is_destroyed):
		return
	
	# Place piece
	var new_piece
	if(direction % 2 == 0):
		new_piece = pole.instantiate()
	else:
		new_piece = platform.instantiate()
	new_piece.global_position = placement_position
	taken_spots[placement_position] = new_piece
	worldmap.add_child.call_deferred(new_piece)
	placed += 1

func move_random_and_place():
	move_and_place(randi()%4)

func move_random_and_place_climbable():
	if !already_placed_verticle:
		var direction = randi()%4
		if(direction % 2 == 0):
			already_placed_verticle = true
		move_and_place(direction)
	else:
		move_and_place((randi()%2) * 2 + 1)
		already_placed_verticle = false
	
func move_random():
	var direction = randi()%4;
	move(direction)
	return direction

func move(direction):
	if(currently_saving):
		restart_directions.append(direction)
	var prev_position = Vector2(global_position)
	var size = grid_border
	global_position += direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)
	if global_position.x > size.x || global_position.x < -size.x || global_position.y > size.y || global_position.y < -size.y:
		global_position = prev_position
	return direction

func _on_timer_timeout():
	if(target_position != null && randi()%3 != -1):
		if(abs(target_position.x - global_position.x) > abs(target_position.y - global_position.y) || already_placed_verticle):
			already_placed_verticle = false
			if(target_position.x - global_position.x < 0):
				move_and_place(3)
			else:
				move_and_place(1)
		else:
			already_placed_verticle = true
			if(target_position.y - global_position.y < 0):
				move_and_place(0)
			else:
				move_and_place(2)
		if(global_position.distance_to(target_position) < 60):
			target_position = null
			$"../Target".hide()
	else:
		move_random_and_place_climbable()
		
func place_coin():
	var c = coins.instantiate()
	c.global_position = global_position
	restart_coins.append(global_position)
	worldmap.add_child.call_deferred(c)
	return c
