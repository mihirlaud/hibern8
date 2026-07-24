extends Control

@onready var label: RichTextLabel = $MarginContainer/VBoxContainer/Label
@onready var results_label: Label = $MarginContainer/VBoxContainer/ResultsLabel
@onready var next_button: Button = $MarginContainer/VBoxContainer/NextButton

const DISPLAY_TIME_IN_S = 4.0
const WAIT_TIME_IN_S = 1.0
var elapsed_time = 0.0
var results = []
var results_strings = ["\n", "\n", "\n", "\n", ""]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	elapsed_time = 0.0
	var days_left = str(GameState.TOTAL_NUM_DAYS - GameState.current_day)
	label.text = "Day [b]" + str(GameState.current_day) + "[/b] ends.\n\n[b]" + days_left
	if days_left == "1":
		label.text += "[/b] day remains"
	else:
		label.text += "[/b] days remain"
	
	var food_days = int(floor(GameState.get_food() / 3.0))
	var water_days = int(floor(GameState.get_water() / 3.0))
	var power_days = int(floor(GameState.get_power() / 10.0))
	var actual_days = min(food_days, water_days, power_days)
	
	results.append("Every day, you use 3 cans of food, 3 bottles of water, and 10 kWh of power.\n")
	results.append("You have " + str(int(floor(GameState.get_food()))) + " cans of food, which will last you " + str(food_days) + " days.\n")
	results.append("You have " + str(int(floor(GameState.get_water()))) + " bottles of water, which will last you " + str(water_days) + " days.\n")
	results.append("You have " + str(int(floor(GameState.get_power()))) + " kWh of power, which will last you " + str(power_days) + " days.\n")
	results.append("You will only survive " + str(actual_days) + " days.")
	
	next_button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	label.visible_ratio = min(1.0, elapsed_time / DISPLAY_TIME_IN_S)
	
	for i in range(len(results_strings)):
		if elapsed_time >= DISPLAY_TIME_IN_S + (i * 1) * WAIT_TIME_IN_S:
			results_strings[i] = results[i]
	
	results_label.text = ""
	for result_string in results_strings:
		results_label.text += result_string
		
	if elapsed_time >= DISPLAY_TIME_IN_S + len(results_strings) * WAIT_TIME_IN_S:
		next_button.disabled = false


func _on_next_button_pressed() -> void:
	if GameState.current_day == GameState.TOTAL_NUM_DAYS:
		get_tree().change_scene_to_file("res://scenes/game-end.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
