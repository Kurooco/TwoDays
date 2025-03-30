extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween().set_loops(0)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .5)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, .5)
	tween.bind_node($"..")

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
	$AudioStreamPlayer2D.play()
	if(!Autoload.retrying):
		$"/root/Autoload".coins -= 1
