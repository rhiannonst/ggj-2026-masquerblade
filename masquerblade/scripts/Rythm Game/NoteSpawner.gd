extends Node2D
class_name NoteSpawner
@export var bpm := 100.0
var rotate = 0
var note = load("res://scenes/Rythm Game/Note.tscn")
func _initialize() -> void:
	var time = 0
	while true:
		_spawn_note()
		await wait(bpm/60.0)
func wait(seconds):
	await get_tree().create_timer(seconds).timeout
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _spawn_note():
	var instance = note.instantiate()
	add_child(instance)
	instance.initialize(rotate)
	rotate+=1
	if rotate > 3:
		rotate = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
