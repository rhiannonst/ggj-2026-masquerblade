extends Node2D

@export var enemy_sprite: Sprite2D

@export var enemy_textures: Array[Texture2D]

@onready var viewport_size := get_viewport_rect().size

func _ready():
	scale = viewport_size / Vector2(640, 680)
	var state := GameEvents.current_game_state
	
