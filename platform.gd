extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("down") && !$PlayerDestroy.get_overlapping_bodies().is_empty()):
		destroy(position, 100)


func destroy(p, r):
	if(p.distance_to(position) < r):
		queue_free()
