extends Node

@export var opening_scene : PackedScene
var level_stack : Array
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.game_manager = self
	add_scene_to_stack(opening_scene)
	
func add_scene_to_stack(level: PackedScene):
	var new_level = level.instantiate()
	add_child(new_level)
	level_stack.append(new_level)
	current_scene = new_level
	
func pop():
	if(!level_stack.is_empty()):
		level_stack.pop_back().queue_free()
		if(!level_stack.is_empty()):
			add_child(level_stack.back())

func replace_with_scene(level: PackedScene):
	pop()
	add_scene_to_stack(level)
