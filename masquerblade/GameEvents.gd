extends Node

signal request_ui_change(scene_name: String, delete: bool)
signal request_2d_change(scene_name: String, delete: bool)
signal request_world_2d_clear()

signal note_hit(lane: int)  # Triggered when player hits a note
signal note_missed()        # Triggered when player misses or hits wrong key
signal enemy_damaged(amount: int)
signal player_damaged(amount: int)

signal battle_ended
signal move_to_next_location # To tell DanceFloor to move the player

# Progress Tracking
var current_game_state : int = 2 # 0 = Fight 1, 1 = Fight 2, 2 = Boss
