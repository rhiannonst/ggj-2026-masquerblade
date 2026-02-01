extends Area2D
class_name note
var speed = 600 # Adjusted for better feel
var lane = 0


func initialize(incoming_lane):
	lane = incoming_lane
	# Position notes horizontally based on lane
	position.x = (lane - 1.5) * 150
	position.y = 0 
	$AnimatedSprite2D.frame = lane

func _process(delta: float) -> void:
	# Move UP toward the target (or DOWN, depending on your UI)
	position.y += speed * delta
	
	# Auto-delete if it goes off screen to save memory
	if position.y > 750:
		queue_free()
 
