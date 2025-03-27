extends CanvasLayer

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Panel.modulate.a = 0
	$Panel.scale = Vector2()
	tween = get_tree().create_tween()
	tween.tween_property($Panel, "modulate", Color.WHITE, 1).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Panel, "scale", Vector2(1, 1), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops(5)
	#tween.tween_callback($Panel.queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
