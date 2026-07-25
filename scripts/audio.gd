extends AudioStreamPlayer

var blip_player = AudioStreamPlayer.new()
var blop_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blip_player.stream = preload("res://ui/audio/type-blip.wav")
	blip_player.volume_db = -5.0
	add_child(blip_player)
	
	blop_player.stream = preload("res://ui/audio/line-blop.wav")
	blop_player.volume_db = -5.0
	add_child(blop_player)

func play_blip() -> void:
	blip_player.play()

func play_blop() -> void:
	blop_player.play()
