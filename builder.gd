extends Node2D

@export var platform : PackedScene
@export var pole : PackedScene
@export var worldmap : Node
var taken_spots = {}

const GRID_WIDTH = 50
const GRID_HEIGHT = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 100)
	for i in 10:
		move_random()
		var newplat = platform.instantiate()
		newplat.position = position
		worldmap.add_child.call_deferred(newplat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move_random():
	var direction = randi()%4;
	var direction_map = {0: Vector2.UP, 1: Vector2.RIGHT, 2: Vector2.DOWN, 3: Vector2.LEFT}
	position += direction_map[direction] * (GRID_HEIGHT if direction % 2 == 0 else GRID_WIDTH)
	return direction_map[direction]
