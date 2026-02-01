extends Control

func resume():
	get_tree().paused = false
	visible = false

func pause():
	get_tree().paused = true
	visible = true

func _on_continue_pressed() -> void:
	resume()
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == Key.KEY_ESCAPE:
			if get_tree().paused:
				resume()
			else:
				pause()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	#Global.game_controller.clear_world_2d()
	#Global.game_controller.change_ui_scene("startScreen", true)
	GameEvents.request_world_2d_clear.emit()
	GameEvents.request_ui_change.emit("startScreen", true)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	resume()
