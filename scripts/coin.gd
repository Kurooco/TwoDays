extends Area2D

var turn_red = true
@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(turn_red):
		sprite.modulate.b = move_toward(sprite.modulate.b, 0, delta)
		sprite.modulate.g = sprite.modulate.b
		if(sprite.modulate.b == 0):
			turn_red = false
	else:
		sprite.modulate.b = move_toward(sprite.modulate.b, 1, delta)
		sprite.modulate.g = sprite.modulate.b
		if(sprite.modulate.b == 1):
			turn_red = true


func _on_body_entered(body):
	$AnimatedSprite2D.hide()


func _on_tree_exiting():
	pass


func _on_cpu_particles_2d_finished():
	queue_free()


func _on_animated_sprite_2d_hidden():
	$CPUParticles2D.emitting = true
	$AudioStreamPlayer2D.play()
	if(!Autoload.retrying):
		$"/root/Autoload".coins -= 1
