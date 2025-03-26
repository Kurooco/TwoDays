extends Button

@export var scene : String
@export_enum("None", "Replace Previous", "Clear All", "Go Back") var replacement_mode: int
@export var hide_previous_screen = false
@export var set_pause : bool

func _on_button_down():
	print_debug(scene)
	if(replacement_mode == 0):
		Autoload.game_manager.pause_current(set_pause)
		Autoload.game_manager.add_scene_to_stack(load(scene), hide_previous_screen)
	if(replacement_mode == 1):
		Autoload.game_manager.replace_with_scene(load(scene))
	if(replacement_mode == 2):
		Autoload.game_manager.clear_stack()
		Autoload.game_manager.add_scene_to_stack(load(scene), hide_previous_screen)
	if(replacement_mode == 3):
		Autoload.game_manager.pop()
		Autoload.game_manager.pause_current(set_pause)
