extends Node

var music_instance

func _ready():
	# 1. Wait a frame to ensure the FMOD singleton is fully registered and active
	await get_tree().process_frame
	setup_music()

func setup_music():
	# 2. IMPORTANT: Use FmodServer (lowercase 'mod') or FMOD (uppercase) 
	# exactly as it appears in your editor's autocomplete.
	# The plugin usually registers 'FmodServer' as the global instance.
	music_instance = FmodServer.create_event_instance("event:/Music/MainTrack")
	
	if music_instance:
		music_instance.start()
		set_state("Menu")
	else:
		print("FMOD Error: Event not found at path 'event:/Music/MainTrack'")

func set_state(label: String):
	if music_instance:
		# Use the instance to set parameters
		music_instance.set_parameter_by_name_with_label("GameState", label)
