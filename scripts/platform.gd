extends RigidBody2D

var FADE_RATE = 0.5

var is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = randi()%4
	set_physics_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("down") && !$PlayerDestroy.get_overlapping_bodies().is_empty()):
		destroy(position, 100)
	if(is_destroyed):
		#print_debug($Sprite2D.modulate.a)
		$Sprite2D.modulate.a = move_toward($Sprite2D.modulate.a, 0, delta*FADE_RATE)
		if($Sprite2D.modulate.a == 0):
			queue_free()


func destroy(p, r):
	if(p.distance_to(position) < r):
		set_collision_layer_value(2, false)
		set_collision_layer_value(3, false)
		gravity_scale = 1
		apply_impulse(p.direction_to(position)*200)
		$CollisionShape2D.set_deferred("one_way_collision", false)
		is_destroyed = true
		set_physics_process(true)
		#queue_free()
