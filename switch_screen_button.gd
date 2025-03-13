extends Button

@export var scene : PackedScene
@export var replace_previous_scene : bool = true

func _on_button_down():
	if(replace_previous_scene):
		Autoload.game_manager.replace_with_scene(scene)
	else:
		Autoload.game_manager.add_scene_to_stack(scene)
