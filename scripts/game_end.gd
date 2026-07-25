extends Control

@onready var label: RichTextLabel = $BG/MarginContainer/VBoxContainer/Label
@onready var replay_button: Button = $BG/MarginContainer/VBoxContainer/ReplayButton

const DISPLAY_TIME_IN_S = 5.0
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.stop_bg_music()
	Audio.play_siren()
	Audio.set_geiger(1.0)
	Audio.play_geiger()
	
	var food_usage_rate = GameState.usage_rate_food()
	var water_usage_rate = GameState.usage_rate_water()
	var power_usage_rate = GameState.usage_rate_power()
	
	var food_days = int(floor(GameState.get_food() / food_usage_rate))
	var water_days = int(floor(GameState.get_water() / water_usage_rate))
	var power_days = int(floor(GameState.get_power() / power_usage_rate))
	var actual_days = min(food_days, water_days, power_days)
	
	label.text = "Winter begins.\n\n"
	label.text += "You will only survive [b]" + str(actual_days) + "[/b] days.\n"
	replay_button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	var prev_vis_char = label.visible_characters
	label.visible_ratio = min(1.0, elapsed_time / DISPLAY_TIME_IN_S)
	var new_vis_char = label.visible_characters
	
	if prev_vis_char != new_vis_char:
		Audio.play_blip()
	
	if elapsed_time >= DISPLAY_TIME_IN_S:
		replay_button.disabled = false

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
