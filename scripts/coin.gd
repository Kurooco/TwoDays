extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$AnimatedSprite2D.hide()


func _on_tree_exiting():
	pass


func _on_cpu_particles_2d_finished():
	queue_free()


func _on_animated_sprite_2d_hidden():
	$CPUParticles2D.emitting = true
	if(!Autoload.retrying):
		$"/root/Autoload".coins -= 1
