extends Control

@onready var food_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/FoodGenButton
@onready var food_label: RichTextLabel = $MarginContainer/VBoxContainer/GridContainer/FoodLabel
@onready var water_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/WaterGenButton
@onready var water_label: RichTextLabel = $MarginContainer/VBoxContainer/GridContainer/WaterLabel
@onready var power_gen_button: Button = $MarginContainer/VBoxContainer/GridContainer/PowerGenButton
@onready var power_label: RichTextLabel = $MarginContainer/VBoxContainer/GridContainer/PowerLabel

@onready var day_timer: Timer = $DayTimer

@onready var food_gen_timer: Timer = $FoodGenTimer
@onready var water_gen_timer: Timer = $WaterGenTimer
@onready var power_gen_timer: Timer = $PowerGenTimer

@onready var food_progress_bar: ProgressBar = $MarginContainer/VBoxContainer/GridContainer/FoodGenButton/FoodProgressBar
@onready var water_progress_bar: ProgressBar = $MarginContainer/VBoxContainer/GridContainer/WaterGenButton/WaterProgressBar
@onready var power_progress_bar: ProgressBar = $MarginContainer/VBoxContainer/GridContainer/PowerGenButton/PowerProgressBar

@onready var day_label: Label = $DayLabel
@onready var clock_label: Label = $ClockLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_timer.wait_time = GameState.DAY_LENGTH_IN_S
	day_timer.start()
	day_label.text = "Day " + str(GameState.current_day)
	clock_label.text = "06:00"
	
	if GameState.TOTAL_NUM_DAYS - GameState.current_day < 3:
		var volumes = [0.5, 0.25, 0.10]
		Audio.set_geiger(volumes[GameState.TOTAL_NUM_DAYS - GameState.current_day])
		Audio.play_geiger()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameState.run_gen(delta)
	
	var food_first_half = "Food: " + str(int(floor(GameState.get_food()))) + " / " + str(int(floor(GameState.get_food_max())))
	var water_first_half = "Water: " + str(int(floor(GameState.get_water()))) + " / " + str(int(floor(GameState.get_water_max())))
	var power_first_half = "Power: " + str(int(floor(GameState.get_power()))) + " / " + str(int(floor(GameState.get_power_max())))
	
	var length = max(food_first_half.length(), water_first_half.length(), power_first_half.length())
	food_first_half = food_first_half.rpad(length, " ")
	water_first_half = water_first_half.rpad(length, " ")
	power_first_half = power_first_half.rpad(length, " ")
	
	food_label.text = food_first_half + " " + get_progress_bar(GameState.Resources.FOOD)
	water_label.text = water_first_half + " " + get_progress_bar(GameState.Resources.WATER)
	power_label.text = power_first_half + " " + get_progress_bar(GameState.Resources.POWER)
	
	if food_gen_timer.time_left != 0.0:
		food_progress_bar.value = 100.0 * (1.0 - food_gen_timer.time_left / GameState.food_timer())
	else:
		food_progress_bar.value = 0.0
		
	if water_gen_timer.time_left != 0.0:
		water_progress_bar.value = 100.0 * (1.0 - water_gen_timer.time_left / GameState.water_timer())
	else:
		water_progress_bar.value = 0.0
		
	if power_gen_timer.time_left != 0.0:
		power_progress_bar.value = 100.0 * (1.0 - power_gen_timer.time_left / GameState.power_timer())
	else:
		power_progress_bar.value = 0.0
		
	var minutes_in = int(floor(720.0 * (1.0 - day_timer.time_left / GameState.DAY_LENGTH_IN_S)))
	var hours = minutes_in / 60 + 6
	var mins = minutes_in % 60
	clock_label.text = str(hours).lpad(2, "0") + ":" + str(mins).lpad(2, "0")
	if day_timer.time_left <= 10.0:
		if round(day_timer.time_left) > day_timer.time_left:
			clock_label.text = ""

func get_progress_bar(resource) -> String:
	var amount_possessed = GameState.get_resource(resource)
	var amount_max = GameState.get_resource_max(resource)
	var resource_per_box = int(amount_max / 25)
	var num_boxes = int(floor(amount_possessed / resource_per_box))
	var return_value = "["
	for i in range(num_boxes):
		return_value += "[char=2588]"
	for i in range(25 - num_boxes):
		return_value += "."
	return_value += "]"
	
	return return_value
	

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
