extends Node2D
class_name NoteButtonSpawner
@export var lanes:= 4
var note = load("res://scenes/Rythm Game/NoteButton.tscn")
var lane_cycle = 0


func _ready() -> void:
	#start music here
	for i in range(lanes):
		_spawn_note()
	pass

func _spawn_note():
	var instance = note.instantiate()
	add_child(instance)
	instance.initialize(lane_cycle)
	lane_cycle = (lane_cycle + 1) % 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
