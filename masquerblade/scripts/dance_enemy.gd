extends AnimatedSprite2D


var health = 20

func _ready() -> void:
	# Connect to the Signal Bus
	print("ENEMY IS ACTIVE AND LISTENING")
	GameEvents.enemy_damaged.connect(_on_damaged)
	play("idle")

func _on_damaged(amount: int) -> void:
	health -= amount
	print("Enemy took damage! Remaining health: ", health)
	if health <= 0:
		_die()
		return

func _die() -> void:
	stop()
	GameEvents.battle_ended.emit()
	
	# Increment progress
	GameEvents.current_game_state += 1
	# Stop the enemy from taking more damage
	if GameEvents.enemy_damaged.is_connected(_on_damaged):
		GameEvents.enemy_damaged.disconnect(_on_damaged)
	# Tell the controller to switch to different scene
	if GameEvents.current_game_state >= 3:
		print("Boss defeated! Heading to Victory Screen.")
		GameEvents.request_world_2d_clear.emit()
		GameEvents.request_ui_change.emit("Victory", true)
	else:
		# Otherwise, go back to the club to walk to the next spot
		GameEvents.request_2d_change.emit("DanceFloor", true)
