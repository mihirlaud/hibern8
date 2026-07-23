extends Node2D

@onready var food_label: Label = $FoodLabel
@onready var water_label: Label = $WaterLabel
@onready var power_label: Label = $PowerLabel

@onready var timer_label: Label = $TimerLabel
@onready var day_timer: Timer = $DayTimer

@onready var food_gen_timer: Timer = $FoodGenTimer
@onready var water_gen_timer: Timer = $WaterGenTimer
@onready var power_gen_timer: Timer = $PowerGenTimer

@onready var food_gen_button: Button = $FoodGenButton
@onready var water_gen_button: Button = $WaterGenButton
@onready var power_gen_button: Button = $PowerGenButton

var food_generating = false
var water_generating = false
var power_generating = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_timer.wait_time = GameState.DAY_LENGTH_IN_S
	day_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameState.run_gen(delta)
	
	timer_label.text = str(round(day_timer.time_left * 10) / 10.0) + " s"
	food_label.text = "Food: " + str(floor(GameState.food)) + " / " + str(floor(GameState.max_food))
	water_label.text = "Water: " + str(floor(GameState.water)) + " / " + str(floor(GameState.max_water))
	power_label.text = "Power: " + str(floor(GameState.power)) + " / " + str(floor(GameState.max_power))

func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/day-end.tscn")

func _on_food_gen_button_pressed() -> void:
	if not food_generating:
		food_gen_timer.wait_time = GameState.manual_food_gen_timer
		food_gen_timer.start()
		food_generating = true
		food_gen_button.text = "Canning food..."

func _on_food_gen_timer_timeout() -> void:
	food_generating = false
	GameState.food += GameState.manual_food_gen
	food_gen_button.text = "Can Food"

func _on_water_gen_button_pressed() -> void:
	if not water_generating:
		water_gen_timer.wait_time = GameState.manual_water_gen_timer
		water_gen_timer.start()
		water_generating = true
		water_gen_button.text = "Bottling water..."

func _on_water_gen_timer_timeout() -> void:
	water_generating = false
	GameState.water += GameState.manual_water_gen
	water_gen_button.text = "Bottle water"

func _on_power_gen_button_pressed() -> void:
	if not power_generating:
		power_gen_timer.wait_time = GameState.manual_power_gen_timer
		power_gen_timer.start()
		power_generating = true
		power_gen_button.text = "Generating power..."

func _on_power_gen_timer_timeout() -> void:
	power_generating = false
	GameState.power += GameState.manual_power_gen
	power_gen_button.text = "Generate power"
