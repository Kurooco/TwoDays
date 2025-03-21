extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	Autoload.retrying = true
	await get_tree().physics_frame
	Autoload.game_manager.clear_stack()
	Autoload.game_manager.add_scene_to_stack(load("res://scenes/main.tscn"))
