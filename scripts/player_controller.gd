extends Node2D

var camera_mode = false
var camera_locked = false
var camera_rate = .03
var outward_zoom : Vector2
signal player_died

# Called when the node enters the scene tree for the first time.
func _ready():
	outward_zoom = Vector2(get_viewport_rect().size.x/($"/root/Autoload".border.x*4), get_viewport_rect().size.y/($"/root/Autoload".border.y*4))
	$Camera2D.limit_top = $"/root/Autoload".border.y*-2 - 10
	$Camera2D.limit_bottom = $"/root/Autoload".border.y*2 + 10
	$Camera2D.limit_right = $"/root/Autoload".border.x*2
	$Camera2D.limit_left = $"/root/Autoload".border.x*-2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("toggle camera") && !camera_locked):
		camera_mode = !camera_mode
	if(camera_mode):
		$Camera2D.position = lerp($Camera2D.position, $CharacterBody2D.position, 1 - pow(camera_rate, delta))
		$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(.9, .9), 1 - pow(camera_rate, delta))
	else:
		$Camera2D.position = lerp($Camera2D.position, Vector2(0, 0), 1 - pow(camera_rate, delta))
		$Camera2D.zoom = lerp($Camera2D.zoom, outward_zoom, 1 - pow(camera_rate, delta))

func _on_on_screen_rect_exit_rect():
	pass
	
func die():
	emit_signal("player_died")
	lock_camera_out()
	
func lock_camera_out():
	camera_locked = true
	camera_mode = false
	
func lock_camera_in():
	camera_locked = true
	camera_mode = true

func _on_on_screen_rect_fell():
	die()
	print_debug("Yep, that's gone")
	hide()
