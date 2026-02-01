extends Area2D
var speed = 100
func initialize(lane):
	print("note spawned")
	position.x += lane*150
	$AnimatedSprite2D.frame = lane
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta
	
