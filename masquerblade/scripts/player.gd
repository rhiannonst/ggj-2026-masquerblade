extends CharacterBody2D
#used Google Gemini to learn about tweens
@onready var target_node_1: Node2D = $"../EnemyLocation1"
@onready var target_node_2: Node2D = $"../EnemyLocation2"
@onready var target_node_3: Node2D = $"../BossLocation"


var game_state = 0

func _ready():
	if game_state == 0:
		move_to_initial_target()

func move_to_initial_target():
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_1.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_1)

func _on_reached_location_1():
	print("Character arrived! Starting first dance...")
	
	# Load your minigame scene or toggle UI here
	#start_minigame_logic()

func _first_dance_success():
	game_state = 1
	move_to_secondary_target()
	
func move_to_secondary_target():
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_2.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_2)
	
func _on_reached_location_2():
	print("Character arrived! Starting second dance...")
	
	# Load your minigame scene or toggle UI here
	#start_minigame_logic()

func _second_dance_success():
	game_state = 2
	move_to_boss_target()
	
func move_to_boss_target():
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_3.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_3)
	
func _on_reached_location_3():
	print("Character arrived! Starting boss dance...")
	
	# Load your minigame scene or toggle UI here
	#start_minigame_logic()
