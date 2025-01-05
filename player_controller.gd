extends Node2D

var camera_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("toggle camera")):
		camera_mode = !camera_mode
	if(camera_mode):
		$Camera2D.position = lerp($Camera2D.position, $CharacterBody2D.position, .03)
		$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(.9, .9), .03)
	else:
		$Camera2D.position = lerp($Camera2D.position, Vector2(0, 0), .03)
		$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(.25, .25), .03)
