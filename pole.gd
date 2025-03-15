extends RigidBody2D

var FADE_RATE = 0.5

var is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_destroyed):
		#print_debug($Sprite2D.modulate.a)
		$Sprite2D.modulate.a = move_toward($Sprite2D.modulate.a, 0, delta*FADE_RATE)
		if($Sprite2D.modulate.a == 0):
			queue_free()


func destroy(p, r):
	if(p.distance_to(position) < r):
		set_collision_layer_value(2, false)
		gravity_scale = 1
		apply_impulse(p.direction_to(position)*200)
		$CollisionShape2D.set_deferred("one_way_collision", false)
		is_destroyed = true
