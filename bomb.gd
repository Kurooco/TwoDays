extends Area2D

const FIRE_SPEED = 10
const RADIUS = 200

var fire_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	fire_direction = rotation
	rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(cos(fire_direction)*FIRE_SPEED)
	move_local_y(sin(fire_direction)*FIRE_SPEED)


func _on_area_entered(area):
	get_tree().call_group("structure", "destroy", position, RADIUS)
	queue_free()


func _on_on_screen_rect_exit_rect():
	queue_free()
