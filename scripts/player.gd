extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -320.0
const TERMINAL_VELOCITY = 250

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jump = true
var start_position

func _ready():
	start_position = global_position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if(velocity.y > TERMINAL_VELOCITY):
			velocity.y = TERMINAL_VELOCITY

	# Handle jump.
	if(is_on_floor()):
		has_jump = true
	if Input.is_action_pressed("up") and has_jump:
		velocity.y = JUMP_VELOCITY
		has_jump = false

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if !is_on_floor():
		$Sprite2D.play("jump")
	elif direction:
		$Sprite2D.flip_h = direction == -1
		$Sprite2D.play("walk")
	else:
		$Sprite2D.play("stand")
	
	move_and_slide()
	
func restart():
	global_position = start_position
