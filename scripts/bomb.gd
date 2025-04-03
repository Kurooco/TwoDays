extends Area2D

const FIRE_SPEED = 800
const RADIUS = 200

var fire_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	fire_direction = rotation
	rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(cos(fire_direction)*FIRE_SPEED*delta)
	move_local_y(sin(fire_direction)*FIRE_SPEED*delta)
	if(get_overlapping_bodies().size() > 0):
		explode()
		set_process(false)


func _on_area_entered(area):
	#get_tree().call_group("structure", "destroy", position, RADIUS)
	#explode()
	pass


func _on_on_screen_rect_exit_rect():
	queue_free()


func _on_body_entered(body):
	#get_tree().call_group("structure", "destroy", position, RADIUS)
	#explode()
	pass

func explode():
	get_tree().call_group("structure", "destroy", position, RADIUS)
	$Explosion.emitting = true
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()

