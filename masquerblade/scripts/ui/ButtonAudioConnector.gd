extends Control

func _ready():
	# Find all buttons under this menu and connect their signals
	for child in get_all_buttons(self):
		child.mouse_entered.connect(AudioManager.play_ui_hover)
		child.pressed.connect(AudioManager.play_ui_select)

# Helper function to find buttons even if they are deep in VBox/HBox containers
func get_all_buttons(node) -> Array:
	var buttons = []
	if node is Button:
		buttons.append(node)
	for child in node.get_children():
		buttons.append_array(get_all_buttons(child))
	return buttons
