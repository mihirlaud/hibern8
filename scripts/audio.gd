extends AudioStreamPlayer

var blip_player = AudioStreamPlayer.new()
var blop_player = AudioStreamPlayer.new()
var bg_music_player = AudioStreamPlayer.new()
var siren_player = AudioStreamPlayer.new()
var geiger_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blip_player.stream = preload("res://ui/audio/type-blip.wav")
	blip_player.volume_db = -8.0
	add_child(blip_player)
	
	blop_player.stream = preload("res://ui/audio/line-blop.wav")
	blop_player.volume_db = -8.0
	add_child(blop_player)
	
	bg_music_player.stream = preload("res://ui/audio/bg-music.wav")
	bg_music_player.volume_db = -10.0
	add_child(bg_music_player)
	
	siren_player.stream = preload("res://ui/audio/siren.wav")
	siren_player.volume_db = -15.0
	add_child(siren_player)
	
	geiger_player.stream = preload("res://ui/audio/geiger.wav")
	geiger_player.volume_linear = 0.0
	add_child(geiger_player)

func play_blip() -> void:
	blip_player.play()

func play_blop() -> void:
	blop_player.play()

func play_bg_music() -> void:
	bg_music_player.play()

func stop_bg_music() -> void:
	if bg_music_player.playing:
		bg_music_player.stop()

func play_siren() -> void:
	siren_player.play()

func stop_siren() -> void:
	if siren_player.playing:
		siren_player.stop()

func play_geiger() -> void:
	geiger_player.play()

func stop_geiger() -> void:
	if geiger_player.playing:
		geiger_player.stop()

func mute_geiger() -> void:
	geiger_player.volume_linear = 0.0

func set_geiger(value) -> void:
	geiger_player.volume_linear = value
