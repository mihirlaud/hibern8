extends Node2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.start_day()
	var days_left = str(GameState.TOTAL_NUM_DAYS - GameState.current_day + 1)
	label.text = "Day " + str(GameState.current_day) + " begins.\n" + days_left
	if days_left == "1":
		label.text += " day remains"
	else:
		label.text += " days remain"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/generation.tscn")
