extends AudioStreamPlayer

func _ready():
	# Path to your song
	var song_path = "res://Music/Assets/Music/Masquerblade - Full Song.wav"
	
	# Load the song
	var song_stream = load(song_path)
	
	if song_stream:
		stream = song_stream
		# Ensure it starts playing immediately
		play()
		print("Global Music started: ", song_path)
	else:
		printerr("Could not find music file at: ", song_path)

# You can call GlobalMusic.stop_music() from anywhere later
func stop_music():
	stop()
