class_name GameController extends Node
@onready var fade_overlay: ColorRect = $GUI/FadeOverlay
@export var world_3d : Node3D
@export var world_2d : Node2D
@export var gui : CanvasLayer

var current_3d_scene
var current_2d_scene
var current_gui_scene

const UI_SCENE_PATH := "res://scenes/ui/"
const GAME_SCENE_PATH := "res://scenes/game/"

func change_ui_scene(scene_name: String, delete: bool = true, keep_running: bool = false) -> void:
	var scene_path := UI_SCENE_PATH + scene_name + ".tscn"
	if not ResourceLoader.exists(scene_path):
		push_error("UI scene not found: " + scene_path)
		return
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new = load(scene_path).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func change_2d_scene(scene_name: String, delete: bool = true, keep_running: bool = false, hide_gui: bool = true) -> void:
	get_tree().paused = false
	var game_path := GAME_SCENE_PATH + scene_name + ".tscn"
	if not ResourceLoader.exists(game_path):
		push_error("UI scene not found: " + game_path)
		return
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			#gui.remove_child(current_2d_scene)
			world_2d.remove_child(current_2d_scene)
	if hide_gui and current_gui_scene != null:
		current_gui_scene.queue_free()
		current_gui_scene = null
	var new = load(game_path).instantiate()
	print("Instantiated scene:", new)
	world_2d.add_child(new)
	current_2d_scene = new

func change_3d_scene(scene_name: String, delete: bool = true, keep_running: bool = false, hide_gui: bool = true) -> void:
	var game_path := GAME_SCENE_PATH + scene_name + ".tscn"
	if not ResourceLoader.exists(game_path):
		push_error("UI scene not found: " + game_path)
		return
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free()
		elif keep_running:
			current_3d_scene.visible = false
		else:
			#gui.remove_child(current_3d_scene)
			world_3d.remove_child(current_3d_scene)
	var new = load(game_path).instantiate()
	world_3d.add_child(new)
	current_3d_scene = new

func clear_world_2d() -> void:
	for child in world_2d.get_children():
		child.queue_free()
	current_2d_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.game_controller = self
	GameEvents.request_2d_change.connect(func(name, _del): transition_and_change(name, true))
	GameEvents.request_ui_change.connect(func(name, _del): transition_and_change(name, false))
	GameEvents.request_world_2d_clear.connect(clear_world_2d)
	current_gui_scene = $GUI/startScreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition_and_change(scene_name: String, is_2d: bool):
	var tween = create_tween()
	
	# 1. Fade to black
	tween.tween_property(fade_overlay, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_SINE)
	await tween.finished
	
	# 2. Perform the actual scene swap
	if is_2d:
		change_2d_scene(scene_name)
	else:
		change_ui_scene(scene_name)
	
	# 3. Fade back to transparent
	var tween_back = create_tween()
	tween_back.tween_property(fade_overlay, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_SINE)
