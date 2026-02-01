class_name GameController extends Node

@export var world_3d : Node3D
@export var world_2d : Node2D
@export var gui : Control

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
			gui.remove_child(current_2d_scene)
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
			gui.remove_child(current_3d_scene)
	var new = load(game_path).instantiate()
	world_3d.add_child(new)
	current_3d_scene = new

func clear_world_2d() -> void:
	for child in world_2d.get_children():
		child.queue_free()
	current_2d_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_gui_scene = $GUI/startScreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
