extends Node2D
class_name NoteSpawner
@export var bpm := 120.0
var note = load("res://scenes/Rythm Game/Note.tscn")
var lane_cycle = 0

func _ready() -> void:
	#start music here
	_start_spawning()

func _start_spawning() -> void:
	# 60.0 / 120 bpm = 0.5 seconds per beat
	var beat_interval = 60.0 / bpm 
	
	while true:
		_spawn_note()
		# Wait for exactly one beat
		await get_tree().create_timer(beat_interval).timeout

func _spawn_note():
	var instance = note.instantiate()
	add_child(instance)
	instance.initialize(lane_cycle)
	lane_cycle = (lane_cycle + 1) % 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
