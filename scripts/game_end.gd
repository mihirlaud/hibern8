extends Node2D

@onready var results_label: Label = $ResultsLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var food_days = int(floor(GameState.get_food() / 3.0))
	var water_days = int(floor(GameState.get_water() / 3.0))
	var power_days = int(floor(GameState.get_power() / 10.0))
	var actual_days = min(food_days, water_days, power_days)
	
	results_label.text = "Every day, you use 3 cans of food, 3 bottles of water, and 10 kWh of power.\n"
	results_label.text += "You have " + str(int(floor(GameState.get_food()))) + " cans of food, which will last you " + str(food_days) + " days.\n"
	results_label.text += "You have " + str(int(floor(GameState.get_water()))) + " bottles of water, which will last you " + str(water_days) + " days.\n"
	results_label.text += "You have " + str(int(floor(GameState.get_power()))) + " kWh of power, which will last you " + str(power_days) + " days.\n"
	results_label.text += "You will only survive " + str(actual_days) + " days.\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
