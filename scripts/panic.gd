extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -320.0
const TERMINAL_VELOCITY = 250

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jump = false
var has_turned = false
var move_amount = 0
var direction

func _physics_process(delta):
	if(move_amount <= 0):
		move_amount = randi()%200
		direction = randi()%3-1
		has_turned = false
	else:
		move_amount -= delta*50
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if(velocity.y > TERMINAL_VELOCITY):
			velocity.y = TERMINAL_VELOCITY

	# Handle jump.
	if(is_on_floor()):
		has_jump = true
	if randi()%20 == 0 and has_jump:
		velocity.y = JUMP_VELOCITY
		has_jump = false
	

	# Get the input direction and handle the movement/deacceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if(check_for_change_in_direction() && !has_turned):
		direction *= -1
		has_turned = true
		move_amount += 50
		
	$Sprite2D.flip_h = direction == -1

	move_and_slide()



func _on_on_screen_rect_exit_rect():
	pass


func _on_on_screen_rect_fell():
	queue_free()
	
func check_for_change_in_direction():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, position + Vector2(0, 500), 0b00000000_00000000_00000000_00000010, [self])
	var result = space_state.intersect_ray(query)
	if result:
		return false
	return true
