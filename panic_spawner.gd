extends Node2D

var panic : PackedScene = load("res://panic.tscn")
@export var amount : int
@export var worldmap : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in amount:
		var new_p = panic.instantiate()
		new_p.position = Vector2(randi()%100, position.y)
		worldmap.add_child.call_deferred(new_p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
