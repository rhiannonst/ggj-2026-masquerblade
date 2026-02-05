extends CharacterBody2D
#used Google Gemini to learn about tweens
@onready var target_node_1: Node2D = $"../EnemyLocation1"
@onready var target_node_2: Node2D = $"../EnemyLocation2"
@onready var target_node_3: Node2D = $"../BossLocation"

func _ready():
	match GameEvents.current_game_state:
		0:
			move_to_initial_target()
		1:
			# Teleport to Location 1 first, then move to 2
			global_position = target_node_1.global_position
			move_to_secondary_target()
		2:
			# Teleport to Location 2 first, then move to Boss
			global_position = target_node_2.global_position
			move_to_boss_target()

func move_to_initial_target():
	GameEvents.music_state_changed.emit("moving")
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_1.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_1)

func _on_reached_location_1():
	GameEvents.music_state_changed.emit("destination")
	print("Character arrived! Starting first dance...")
	GameEvents.stage_state_changed.emit(1.0)
	GameEvents.request_debug_print.emit()
	# Load your minigame scene or toggle UI here
	GameEvents.request_2d_change.emit("RhythmGameComplete", true)

func _first_dance_success():
	GameEvents.game_state = 1

	move_to_secondary_target()
	
func move_to_secondary_target():
	GameEvents.music_state_changed.emit("moving")
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_2.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_2)
	
func _on_reached_location_2():
	GameEvents.music_state_changed.emit("destination")
	print("Character arrived! Starting second dance...")
	GameEvents.stage_state_changed.emit(2.0)
	GameEvents.request_debug_print.emit()
	# Load your minigame scene or toggle UI here
	GameEvents.request_2d_change.emit("RhythmGameComplete2nd", true)

func _second_dance_success():
	GameEvents.game_state = 2

	move_to_boss_target()
	
func move_to_boss_target():
	GameEvents.music_state_changed.emit("moving")
	var tween = create_tween()
	# Interpolate global_position from current value to target over 1.0 seconds
	tween.tween_property(self, "global_position", target_node_3.global_position, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_reached_location_3)
	
func _on_reached_location_3():
	GameEvents.music_state_changed.emit("destination")
	print("Character arrived! Starting boss dance...")
	GameEvents.stage_state_changed.emit(3.0)
	GameEvents.request_debug_print.emit()
	# Load your minigame scene or toggle UI here
	GameEvents.request_2d_change.emit("RhythmGameCompleteBoss", true)
