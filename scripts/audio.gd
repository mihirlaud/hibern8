extends AudioStreamPlayer

var blip_player = AudioStreamPlayer.new()
var blop_player = AudioStreamPlayer.new()
var bg_music_player = AudioStreamPlayer.new()

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

func play_blip() -> void:
	blip_player.play()

func play_blop() -> void:
	blop_player.play()

func play_bg_music() -> void:
	bg_music_player.play()

func stop_bg_music() -> void:
	bg_music_player.stop()
