extends Node2D

@onready var hit_zone: Area2D = $HitZone

# Map your lanes to Godot Input Actions
# Make sure "left", "down", etc., are defined in Project Settings > Input Map
var lane_actions = {
	0: "ui_left",
	1: "ui_up",
	2: "ui_right",
	3: "ui_down"
}

func _input(event: InputEvent) -> void:
	# Check each lane to see if the corresponding key was pressed
	for lane_index in lane_actions:
		var action_name = lane_actions[lane_index]
		
		if event.is_action_pressed(action_name):
			_attempt_hit(lane_index)

func _attempt_hit(lane_pressed: int) -> void:
	# Get all notes currently inside the HitZone
	var overlapping_areas = hit_zone.get_overlapping_areas()
	var hit_landed = false
	
	for area in overlapping_areas:
		# Check if the area is a Note and belongs to the lane pressed
		if area is note and area.lane == lane_pressed:
			#print("Perfect! Hit lane: ", lane_pressed)
			GameEvents.note_hit.emit(lane_pressed)
			GameEvents.enemy_damaged.emit(1)
			area.queue_free() # Remove the note from the game
			hit_landed = true
			break # Stop looking once we hit the correct note
			
	if not hit_landed:
		#print("Miss! No note in lane ", lane_pressed)
		GameEvents.note_missed.emit()
		GameEvents.player_damaged.emit(1)
