extends Area2D
class_name noteButton

var lane = 0


func initialize(incoming_lane):
	lane = incoming_lane
	# Position notes horizontally based on lane
	position.x = (lane - 1.5) * 150

	$AnimatedSprite2D.frame = lane

func _process(delta: float) -> void:
	pass
