extends Node2D

@export_enum("Absolute", "Top-Right", "Top-Left", "Bottom-Right", "Bottom-Left") var cannon_positioning : int
@export var worldmap : Node
@export var bombs : PackedScene
@export var lower_range : int
@export var higher_range : int

# Called when the node enters the scene tree for the first time.
func _ready():
	if(cannon_positioning == 1):
		position = Vector2(Autoload.border.x*2, -Autoload.border.y*2)
	if(cannon_positioning == 2):
		position = Vector2(-Autoload.border.x*2, -Autoload.border.y*2)
	if(cannon_positioning == 3):
		position = Vector2(Autoload.border.x*2, Autoload.border.y*2)
	if(cannon_positioning == 4):
		position = Vector2(-Autoload.border.x*2, Autoload.border.y*2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func stop():
	$Timer.stop()
	
func set_time(seconds):
	$Timer.wait_time = seconds
	
func _on_timer_timeout():
	var new_bomb = bombs.instantiate()
	new_bomb.global_position = global_position
	new_bomb.rotation = (lower_range + randi()%int(higher_range-lower_range))*PI/180
	worldmap.add_child(new_bomb)
