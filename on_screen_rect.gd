extends Node2D

signal exit_rect
@export var top_left_rect : Vector2 = Vector2(-2304, -1296)
@export var bottom_right_rect : Vector2 = Vector2(2304, 1296)
@export var use_current_screen_settings : bool


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(use_current_screen_settings):
		if(global_position.x < -$"/root/Autoload".border.x*2 || global_position.x > $"/root/Autoload".border.x*2 || global_position.y < -$"/root/Autoload".border.y*2 || global_position.y > $"/root/Autoload".border.y*2):
			emit_signal("exit_rect")
	else:
		if(global_position.x < top_left_rect.x || global_position.x > bottom_right_rect.x || global_position.y < top_left_rect.y || global_position.y > bottom_right_rect.y):
			emit_signal("exit_rect")
