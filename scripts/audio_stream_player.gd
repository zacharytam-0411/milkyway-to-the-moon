extends AudioStreamPlayer

var playback_positions: Dictionary = {}
var current_track_path: String = ""

func _ready() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, Global.music_volume_db)
	AudioServer.set_bus_mute(music_bus, Global.music_muted)

	Global.connect("bgm_galaxy", Callable(self, "_on_play_galaxy"))
	Global.connect("bgm_odyssey", Callable(self, "_on_play_odyssey"))
	Global.connect("bgm_earth", Callable(self, "_on_play_earth"))
	Global.connect("bgm_mercury", Callable(self, "_on_play_mercury"))
	Global.connect("earth_0", Callable(self, "play_earth_from_start"))
	
func _process(_delta: float) -> void:
	if not Global.play_bgm and playing:
		stop()
	elif Global.play_bgm and not playing:
		play(playback_positions.get(current_track_path, 0.0))

func _on_play_galaxy() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	_switch_and_play("res://audio/space fantasy.mp3", Global.music_volume_db-10, false)

func _on_play_odyssey() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	_switch_and_play("res://audio/odyssey.mp3", Global.music_volume_db, true)
	
func _on_play_earth() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	_switch_and_play("res://audio/earth.mp3", Global.music_volume_db, false)
	
func _on_play_mercury() -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	_switch_and_play("res://audio/mercury.mp3", Global.music_volume_db, false)

func _switch_and_play(new_path: String, target_db: float, is_odyseey: bool) -> void:
	if stream:
		playback_positions[current_track_path] = get_playback_position()
	current_track_path = new_path
	stream = load(new_path)
	if not is_odyseey:
		self.volume_db = -40.0
	else:
		self.volume_db = Global.music_volume_db
	var resume_time = playback_positions.get(new_path, 0.0)
	play(resume_time)
	var tween = create_tween()
	tween.tween_property(self, "volume_db", target_db, 1.5).set_trans(Tween.TRANS_SINE)

func play_earth_from_start() -> void:
	var path = "res://audio/earth.mp3"
	playback_positions[path] = 0.0
	_switch_and_play(path, Global.music_volume_db, false)
