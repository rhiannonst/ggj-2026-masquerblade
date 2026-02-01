extends Node2D

var music_instance
var _banks: Array = [] 

func _ready():
	print("--- FMOD INIT START ---")
	await get_tree().process_frame
	
	if FmodServer.get_listener_number() == 0:
		FmodServer.add_listener(0, self)
		print("Listener added.")

	var base_path = "res://fmodproject/masquerbladefmod/Build/Desktop/"
	
	_load_and_check(base_path + "Master.strings.bank")
	_load_and_check(base_path + "Master.bank")
	_load_and_check(base_path + "Music.bank")
	_load_and_check(base_path + "Menu.bank")
	_load_and_check(base_path + "UI.bank")
	
	print("All banks requested. Waiting for index...")
	#await get_tree().create_timer(0.5).timeout
	

func _load_and_check(path: String):
	var b = FmodServer.load_bank(path, FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	if b:
		_banks.append(b)
		print("Success: ", path.get_file())
	else:
		printerr("CRITICAL FMOD ERROR: Failed to load ", path)

func setup_music():
	print("reached 1: Checking if GUID exists in memory...")
	
	var event_guid = "{992d7086-ba3c-42be-ba77-2796d6247363}"
	
	# Safety Check: If FMOD doesn't see this GUID, it returns an empty object.
	# Calling .is_valid() on a null object is what causes the silent crash.
	if not FmodServer.get_event_from_guid(event_guid):
		printerr("CRITICAL: GUID not found in loaded banks! Did you build in FMOD Studio?")
		return

	music_instance = FmodServer.create_event_instance(event_guid)
	
	if music_instance and music_instance.is_valid():
		print("reached 2: Audio engine linked. Playing...")
		music_instance.start()
	else:
		printerr("reached 2: Instance creation failed.")

func set_state(label: String):
	if music_instance and music_instance.is_valid():
		music_instance.set_parameter_by_name_with_label("GameState", label)
