extends CharacterBody2D
#used Google Gemini to learn about tweens
@onready var target_node: Node2D = $"../EnemyLocation1"
var game_state = 0

func _ready():
	if game_state == 0:
		move_to_initial_target()

func move_to_initial_target():
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location)

func _on_reached_location():
	print("Character arrived! Starting first dance...")
	# Load your minigame scene or toggle UI here
	#start_minigame_logic()
