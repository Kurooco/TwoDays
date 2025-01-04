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
	for i in 10:
		move_random_and_place()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move_random_and_place():
	var direction = move_random()
	var new_piece
	if(direction % 2 == 0):
		new_piece = pole.instantiate()
	else:
		new_piece = platform.instantiate()
		
	new_piece.position = position + (direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)/-2)
	worldmap.add_child.call_deferred(new_piece)
	
func move_random():
	var direction = randi()%4;
	move(direction)
	return direction

func move(direction):
	position += direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)
	return direction


func _on_timer_timeout():
	move_random_and_place()
