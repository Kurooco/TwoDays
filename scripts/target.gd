extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Crosshair1.rotation += delta*2
	$Crosshair2.rotation -= delta*3
	$Crosshair1.scale.x = move_toward($Crosshair1.scale.x, 5, delta*30)
	$Crosshair1.scale.y = move_toward($Crosshair1.scale.y, 5, delta*30)
	$Crosshair2.scale.x = move_toward($Crosshair2.scale.x, 15, delta*50)
	$Crosshair2.scale.y = move_toward($Crosshair2.scale.y, 15, delta*50)
	
func focus():
	print_debug("Focus")
	$Crosshair1.scale = Vector2.ZERO
	$Crosshair2.scale = Vector2(40, 40)
