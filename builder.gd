extends Node2D

@export var platform : PackedScene
@export var pole : PackedScene
@export var worldmap : Node
var taken_spots = {}
var direction_map = {0: Vector2.UP, 1: Vector2.RIGHT, 2: Vector2.DOWN, 3: Vector2.LEFT}

const GRID_WIDTH = 50
const GRID_HEIGHT = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	move_and_place(1)
	for i in 10:
		move_random_and_place()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_and_place(dir):
	var direction = move(dir)
	
	# Check to make sure this spot is not occupied
	var placement_position = global_position + (direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)/-2)
	if(taken_spots.has(placement_position)):
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
	
func move_random_and_place():
	move_and_place(randi()%4)
	
func move_random():
	var direction = randi()%4;
	move(direction)
	return direction

func move(direction):
	var prev_position = Vector2(global_position)
	var size = get_viewport_rect().size
	global_position += direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)
	if global_position.x > size.x || global_position.x < -size.x || global_position.y > size.y || global_position.y < -size.y:
		global_position = prev_position
	return direction

func _on_timer_timeout():
	move_random_and_place()
