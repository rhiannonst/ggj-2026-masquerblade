extends AnimatedSprite2D

var health = 3

func _ready() -> void:
	# Connect to the signal bus
	GameEvents.player_damaged.connect(_on_player_hit)
	play("idle") # Start idle animation

func _on_player_hit(amount: int) -> void:
	if GameEvents.current_fight_index >= 3: 
		return
	health -= amount
	print("Player took damage! Remaining: ", health)
	if health <= 0:
		_die()
		return

func _die() -> void:
	GameEvents.battle_ended.emit()
	# Stop the player from taking more damage
	if GameEvents.player_damaged.is_connected(_on_player_hit):
		GameEvents.player_damaged.disconnect(_on_player_hit)
	# Tell the controller to switch to Game Over
	get_tree().paused = true
	# Ask the controller to show the Game Over UI
	GameEvents.request_world_2d_clear.emit()
	GameEvents.request_ui_change.emit("GameOver", true)
