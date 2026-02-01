extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	print("controls")
	#Global.game_controller.change_ui_scene("startScreen")
	GameEvents.request_ui_change.emit("startScreen", true)
