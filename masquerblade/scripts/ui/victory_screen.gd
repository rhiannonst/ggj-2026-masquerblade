extends Control


func _ready() -> void:
	# Ensure the game is "frozen" so notes don't move in the background
	get_tree().paused = true 
	# Make sure it's visible
	visible = true
	
#

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	GameEvents.request_world_2d_clear.emit()
	GameEvents.request_ui_change.emit("startScreen", true)
	GameEvents.current_game_state = 0
	#stop music

func _on_quit_pressed() -> void:
	get_tree().quit()
