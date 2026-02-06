extends CanvasLayer

@export var max_player_hp: int = 3
@export var max_enemy_hp: int = 20

@onready var player_bar = $PlayerHealthBar
@onready var enemy_bar = $EnemyHealthBar

var current_player_hp: int
var current_enemy_hp: int

func _ready():
	current_player_hp = max_player_hp
	current_enemy_hp = max_enemy_hp
	
	# Initialize the bars
	player_bar.max_value = max_player_hp
	player_bar.value = max_player_hp
	
	enemy_bar.max_value = max_enemy_hp
	enemy_bar.value = max_enemy_hp
	
	# Connect to your GameEvents bus
	GameEvents.player_damaged.connect(_on_player_damaged)
	GameEvents.enemy_damaged.connect(_on_enemy_damaged)

func _on_player_damaged(amount: int):
	current_player_hp = max(0, current_player_hp - amount)
	_animate_bar(player_bar, current_player_hp)
	if current_player_hp <= 0:
		print("Player Defeated!")

func _on_enemy_damaged(amount: int):
	current_enemy_hp = max(0, current_enemy_hp - amount)
	_animate_bar(enemy_bar, current_enemy_hp)
	if current_enemy_hp <= 0:
		print("Enemy Defeated!")

func _animate_bar(bar: ProgressBar, new_val: int):
	var tween = create_tween()
	# Smoothly drain the health
	tween.tween_property(bar, "value", float(new_val), 0.2).set_trans(Tween.TRANS_SINE)
