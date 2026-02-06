extends Node
@onready var fmod_event_emitter_2d = $FmodEventEmitter2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	GameEvents.stage_state_changed.connect(_on_stage_changed)
	GameEvents.request_debug_print.connect(debug_music_parameter)
	GameEvents.request_transitionjingle_start.connect(_on_transitionjingle_start)
	GameEvents.request_music_resume.connect(_on_music_resume)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_stage_changed(new_value: float):
	fmod_event_emitter_2d.set_parameter("stageState", new_value)

func debug_music_parameter():
	# This gets the value currently applied to this specific emitter
	var current_val = fmod_event_emitter_2d.get_parameter("stageState")
	print("FMOD Debug: 'stageState' is currently at: ", current_val)

func _on_transitionjingle_start():
	# 1. Pause the main loop
	fmod_event_emitter_2d.set_paused(true)
	# 2. Play the 10s jingle as a one-shot
	audio_stream_player_2d.play()
	print("Main music paused. Jingle playing...")

func _on_music_resume():
	# 3. Resume the main loop
	audio_stream_player_2d.stop()
	fmod_event_emitter_2d.set_paused(false)
	print("Main music resumed.")
