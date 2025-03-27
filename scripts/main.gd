extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TimeLeft.text = str(round($CanvasLayer/Timer.time_left))
	$CanvasLayer/Coins.text = "Coins left: "+str($"/root/Autoload".coins)
	if($"/root/Autoload".coins == 0):
		#$CanvasLayer/Win.show()
		get_tree().call_group("cannons", "stop")
		$CanvasLayer/Timer.paused = true
		Autoload.game_manager.add_scene_to_stack(load("res://scenes/win_screen.tscn"), false)
		$WinSound.play()
		$MainSong.stop()
		$CanvasLayer/Pause.hide()
		set_process(false)


func _on_timer_timeout():
	get_tree().call_group("cannons", "set_time", .1)


func _on_player_player_died():
	if($"/root/Autoload".coins > 0):
		print_debug("died")
		$LoseSound.play()
		$MainSong.stop()
		$CanvasLayer/Pause.hide()
		Autoload.game_manager.add_scene_to_stack(load("res://scenes/lose_screen.tscn"), false)


func _on_pause_focus_entered():
	Autoload.can_target = false


func _on_pause_focus_exited():
	Autoload.can_target = true

