extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position = get_global_mouse_position()/10


func _on_switch_screen_button_button_down():
	$AudioStreamPlayer.stop()
