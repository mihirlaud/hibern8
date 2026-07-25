extends Control

@onready var start_button: Button = $CenterContainer/VBoxContainer/MarginContainer/StartButton
@onready var label: Label = $CenterContainer/VBoxContainer/Label

var first_run = false

const TITLE = [
	"  /\\\\\\        /\\\\\\  /\\\\\\\\\\\\\\\\\\\\\\  /\\\\\\\\\\\\\\\\\\\\\\\\\\    /\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    /\\\\\\\\\\\\\\\\\\      /\\\\\\\\\\     /\\\\\\     /\\\\\\\\\\\\\\\\\\            ",
	"  \\/\\\\\\       \\/\\\\\\ \\/////\\\\\\///  \\/\\\\\\/////////\\\\\\ \\/\\\\\\///////////   /\\\\\\///////\\\\\\   \\/\\\\\\\\\\\\   \\/\\\\\\   /\\\\\\///////\\\\\\         ",
	"   \\/\\\\\\       \\/\\\\\\     \\/\\\\\\     \\/\\\\\\       \\/\\\\\\ \\/\\\\\\             \\/\\\\\\     \\/\\\\\\   \\/\\\\\\/\\\\\\  \\/\\\\\\  \\/\\\\\\     \\/\\\\\\        ",
	"    \\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\     \\/\\\\\\     \\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\  \\/\\\\\\\\\\\\\\\\\\\\\\     \\/\\\\\\\\\\\\\\\\\\\\\\/    \\/\\\\\\//\\\\\\ \\/\\\\\\  \\///\\\\\\\\\\\\\\\\\\/        ",
	"     \\/\\\\\\/////////\\\\\\     \\/\\\\\\     \\/\\\\\\/////////\\\\\\ \\/\\\\\\///////      \\/\\\\\\//////\\\\\\    \\/\\\\\\\\//\\\\\\\\/\\\\\\   /\\\\\\///////\\\\\\      ",
	"      \\/\\\\\\       \\/\\\\\\     \\/\\\\\\     \\/\\\\\\       \\/\\\\\\ \\/\\\\\\             \\/\\\\\\    \\//\\\\\\   \\/\\\\\\ \\//\\\\\\/\\\\\\  /\\\\\\      \\//\\\\\\    ",
	"       \\/\\\\\\       \\/\\\\\\     \\/\\\\\\     \\/\\\\\\       \\/\\\\\\ \\/\\\\\\             \\/\\\\\\     \\//\\\\\\  \\/\\\\\\  \\//\\\\\\\\\\\\ \\//\\\\\\      /\\\\\\    ",
	"        \\/\\\\\\       \\/\\\\\\  /\\\\\\\\\\\\\\\\\\\\\\ \\/\\\\\\\\\\\\\\\\\\\\\\\\\\/  \\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ \\/\\\\\\      \\//\\\\\\ \\/\\\\\\   \\//\\\\\\\\\\  \\///\\\\\\\\\\\\\\\\\\/    ",
	"         \\///        \\///  \\///////////  \\/////////////    \\///////////////  \\///        \\///  \\///     \\/////     \\/////////     "
]

var current_title = []
var indices_remaining = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameState.first_run:
		GameState.first_run = false
		first_run = true
		start_button.disabled = true
		
		for i in range(len(TITLE)):
			current_title.append("".rpad(TITLE[i].length(), " "))
			for j in range(TITLE[i].length()):
				if TITLE[i][j] != " ":
					indices_remaining.append(i * TITLE[i].length() + j)
	else:
		current_title = TITLE
	
	label.text = ""
	for row in current_title:
		label.text += row + "\n"
	
	Audio.play_bg_music()
	Audio.stop_siren()
	Audio.mute_geiger()
	Audio.stop_geiger()
	Audio.mute_tick()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first_run:
		if len(indices_remaining) > 0:
			var index = indices_remaining.pick_random()
			indices_remaining.erase(index)
			var r = index / TITLE[0].length()
			var c = index % TITLE[0].length()
		
			current_title[r][c] = TITLE[r][c]
		
			label.text = ""
			for row in current_title:
				label.text += row + "\n"
		
		var perfect_match = true
		for i in range(len(TITLE)):
			if current_title[i] != TITLE[i]:
				perfect_match = false
		
		if perfect_match:
			start_button.disabled = false

func _on_start_button_pressed() -> void:
	GameState.init_game()
	get_tree().change_scene_to_file("res://scenes/day-start.tscn")
