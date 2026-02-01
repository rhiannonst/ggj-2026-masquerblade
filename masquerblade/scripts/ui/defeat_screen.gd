extends Control


func _ready() -> void:
	# Ensure the game is "frozen" so notes don't move in the background
	get_tree().paused = true 
	# Make sure it's visible
	visible = true

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	GameEvents.request_world_2d_clear.emit()
	GameEvents.request_ui_change.emit("startScreen", true)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	# 1. Unpause the engine so logic can run again
	get_tree().paused = false
	
	# 2. Re-trigger the current fight based on the saved index
	# This sends the player back into the rhythm scene they just failed
	var current_fight = GameEvents.current_game_state
	var scene_to_load = "RhythmGameComplete" + str(current_fight + 1)
	
	GameEvents.request_2d_change.emit(scene_to_load, true)
