extends Node2D

@onready var food_label: Label = $FoodLabel
@onready var water_label: Label = $WaterLabel
@onready var power_label: Label = $PowerLabel
@onready var money_label: Label = $MoneyLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	food_label.text = "Food: " + str(floor(GameState.food)) + " cans"
	water_label.text = "Water: " + str(floor(GameState.water)) + " bottles"
	power_label.text = "Power: " + str(floor(GameState.power)) + " kWh"
	money_label.text = "Money: $" + str(floor(GameState.money))

func _on_next_button_pressed() -> void:
	if GameState.current_day == GameState.TOTAL_NUM_DAYS:
		get_tree().change_scene_to_file("res://scenes/game-end.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/day-start.tscn")


func _on_sell_food_button_pressed() -> void:
	GameState.sell_food(1)

func _on_sell_water_button_pressed() -> void:
	GameState.sell_water(1)

func _on_sell_power_button_pressed() -> void:
	GameState.sell_power(1)
