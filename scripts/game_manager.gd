extends Node

@export var opening_scene : PackedScene
var level_stack : Array
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.game_manager = self
	add_scene_to_stack(opening_scene, false)
	
func add_scene_to_stack(level: PackedScene, hide_prev: bool):
	var new_level = level.instantiate()
	add_child(new_level)
	if(!level_stack.is_empty()):
		if(hide_prev):
			level_stack.back().hide()
		#print_debug("Hi folks!")
		#set_pause_subtree(level_stack.back(), true)
	level_stack.append(new_level)
	current_scene = new_level
	
func pop():
	if(!level_stack.is_empty()):
		level_stack.pop_back().queue_free()
		if(!level_stack.is_empty()):
			level_stack.back().show()
			current_scene = level_stack.back()
			set_pause_subtree(level_stack.back(), false)

func replace_with_scene(level: PackedScene):
	pop()
	add_scene_to_stack(level, false)

func clear_stack():
	while(!level_stack.is_empty()):
		pop()

func pause_current(pause: bool):
	set_pause_subtree(current_scene, pause)

func set_pause_subtree(root: Node, pause: bool) -> void:
	var process_setters = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input"]
	
	for setter in process_setters:
		root.propagate_call(setter, [!pause])
	root.propagate_call("set", ["paused", pause])
	
	if(pause):
		root.propagate_call("set", ["mouse_filter", Control.MOUSE_FILTER_IGNORE])
	else:
		root.propagate_call("set", ["mouse_filter", Control.MOUSE_FILTER_PASS])
