extends Control

@onready var label: RichTextLabel = $BG/MarginContainer/VBoxContainer/Label
@onready var replay_button: Button = $BG/MarginContainer/VBoxContainer/ReplayButton

const DISPLAY_TIME_IN_S = 5.0
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var food_days = int(floor(GameState.get_food() / 3.0))
	var water_days = int(floor(GameState.get_water() / 3.0))
	var power_days = int(floor(GameState.get_power() / 10.0))
	var actual_days = min(food_days, water_days, power_days)
	
	label.text = "Winter begins.\n\n"
	label.text += "You will only survive [b]" + str(actual_days) + "[/b] days.\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	label.visible_ratio = min(1.0, elapsed_time / DISPLAY_TIME_IN_S)
	if elapsed_time >= DISPLAY_TIME_IN_S:
		replay_button.disabled = false

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
