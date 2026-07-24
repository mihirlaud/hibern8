extends Control

@onready var food_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/FoodGenButton
@onready var food_label: Label = $MarginContainer/VBoxContainer/GridContainer/FoodLabel
@onready var water_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/WaterGenButton
@onready var water_label: Label = $MarginContainer/VBoxContainer/GridContainer/WaterLabel
@onready var power_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/PowerGenButton
@onready var power_label: Label = $MarginContainer/VBoxContainer/GridContainer/PowerLabel
@onready var timer_label: Label = $MarginContainer/VBoxContainer/TimerLabel

@onready var day_timer: Timer = $DayTimer

@onready var food_gen_timer: Timer = $FoodGenTimer
@onready var water_gen_timer: Timer = $WaterGenTimer
@onready var power_gen_timer: Timer = $PowerGenTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_timer.wait_time = GameState.DAY_LENGTH_IN_S
	day_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameState.run_gen(delta)
	
	timer_label.text = "\n" + str(round(day_timer.time_left * 10) / 10.0) + " s"
	food_label.text = "Food: " + str(floor(GameState.get_food())) + " / " + str(floor(GameState.get_food_max())) + " cans"
	water_label.text = "Water: " + str(floor(GameState.get_water())) + " / " + str(floor(GameState.get_water_max())) + " bottles"
	power_label.text = "Power: " + str(floor(GameState.get_power())) + " / " + str(floor(GameState.get_power_max())) + " kWh"

func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/day-end.tscn")

func _on_food_gen_button_pressed() -> void:
	if not GameState.is_food_generating():
		food_gen_timer.wait_time = GameState.food_timer()
		food_gen_timer.start()
		GameState.set_food_generating(true)
		food_gen_button.text = "Canning food..."
		food_gen_button.disabled = true

func _on_food_gen_timer_timeout() -> void:
	GameState.set_food_generating(false)
	GameState.manual_gen_food()
	food_gen_button.text = "Can Food"
	food_gen_button.disabled = false

func _on_water_gen_button_pressed() -> void:
	if not GameState.is_water_generating():
		water_gen_timer.wait_time = GameState.water_timer()
		water_gen_timer.start()
		GameState.set_water_generating(true)
		water_gen_button.text = "Bottling water..."
		water_gen_button.disabled = true

func _on_water_gen_timer_timeout() -> void:
	GameState.set_water_generating(false)
	GameState.manual_gen_water()
	water_gen_button.text = "Bottle water"
	water_gen_button.disabled = false

func _on_power_gen_button_pressed() -> void:
	if not GameState.is_power_generating():
		power_gen_timer.wait_time = GameState.power_timer()
		power_gen_timer.start()
		GameState.set_power_generating(true)
		power_gen_button.text = "Generating power..."
		power_gen_button.disabled = true

func _on_power_gen_timer_timeout() -> void:
	GameState.set_power_generating(false)
	GameState.manual_gen_power()
	power_gen_button.text = "Generate power"
	power_gen_button.disabled = false
