extends Button

@export var scene : PackedScene
@export_enum("None", "Replace Previous", "Clear All", "Go Back") var replacement_mode: int


func _on_button_down():
	if(replacement_mode == 0):
		Autoload.game_manager.add_scene_to_stack(scene)
	if(replacement_mode == 1):
		Autoload.game_manager.replace_with_scene(scene)
	if(replacement_mode == 2):
		Autoload.game_manager.clear_stack()
		Autoload.game_manager.add_scene_to_stack(scene)
	if(replacement_mode == 3):
		Autoload.game_manager.pop()
