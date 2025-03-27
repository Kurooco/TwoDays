extends RigidBody2D

@export var is_horizontal_platform : bool
var FADE_RATE = 0.5
var is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.frame = randi()%4
	call_deferred("set_freeze_enabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_horizontal_platform && Input.is_action_pressed("down") && !$PlayerDestroy.get_overlapping_bodies().is_empty()):
		destroy(position, 100)
	if(is_destroyed):
		#print_debug($Sprite2D.modulate.a)
		$Sprite2D.modulate.a = move_toward($Sprite2D.modulate.a, 0, delta*FADE_RATE)
		if($Sprite2D.modulate.a == 0):
			queue_free()


func destroy(p, r):
	if(p.distance_to(position) < r):
		call_deferred("set_freeze_enabled", false)
		set_collision_layer_value(2, false)
		set_collision_layer_value(3, false)
		gravity_scale = 1
		#apply_impulse(p.direction_to(position)*200)
		call_deferred("apply_impulse", p.direction_to(position)*200)
		call_deferred("set_angular_velocity", randi_range(-5, 5))
		$CollisionShape2D.set_deferred("one_way_collision", false)
		is_destroyed = true
		#queue_free()
