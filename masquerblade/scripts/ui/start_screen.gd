extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("Start")
	Global.game_controller.change_2d_scene("DanceFloor")


func _on_controls_pressed() -> void:
	print("controls")
	Global.game_controller.change_ui_scene("controlScreen")


func _on_quit_pressed() -> void:
	print("quit")
	get_tree().quit()
