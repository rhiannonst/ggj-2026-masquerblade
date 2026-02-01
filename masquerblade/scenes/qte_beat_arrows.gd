extends Node2D

#gets all related nodes, sprites, markers
@onready var keyMatch: Sprite2D = $arrowKeyMatch
@onready var pointer: Sprite2D = $pointer
@onready var start: Marker2D = $start
@onready var end: Marker2D = $end
@onready var startSafe: Marker2D = $safeStartPos
@onready var endSafe: Marker2D = $safeEndPos

#gets the related enemy and player node too for dealing "mask off dmg" to their "hp"
#TODO: replace with actual player/enemy references
@onready var enemy: CharacterBody2D = $"../enemy"
@onready var player: CharacterBody2D = $"../player"


#direction of movement for falling arrows.
var direction = 1 # down!

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float)->void:
	if pointer.position.y <= start.position.y:
		direction = 1
	elif pointer.position.y >= end.position.y :
		direction = -1
	
	pointer.position.y += direction 
	
	if Input.is_action_pressed("ui_accept"):
		if pointer.position.y >= startSafe.position.y and pointer.position.y <= endSafe.position.y :
			#enemy.hurt()
			print("you've successfully clicked in the hit zone !")
		else:
			#player.hurt()
			print("you've critically missed the beat")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
