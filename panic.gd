extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -320.0
const TERMINAL_VELOCITY = 250

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jump = true
var move_amount = 0
var direction

func _physics_process(delta):
	if(move_amount <= 0):
		move_amount = randi()%200
		direction = randi()%3-1
	else:
		move_amount -= 1
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if(velocity.y > TERMINAL_VELOCITY):
			velocity.y = TERMINAL_VELOCITY

	# Handle jump.
	if(is_on_floor()):
		has_jump = true
	if randi()%10 == 0 and has_jump:
		velocity.y = JUMP_VELOCITY
		has_jump = false

	# Get the input direction and handle the movement/deacceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_on_screen_rect_exit_rect():
	queue_free()
