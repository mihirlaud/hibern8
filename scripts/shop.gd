extends Control

@onready var food_label: Label = $MarginContainer2/VBoxContainer/GridContainer/FoodLabel
@onready var water_label: Label = $MarginContainer2/VBoxContainer/GridContainer/WaterLabel
@onready var power_label: Label = $MarginContainer2/VBoxContainer/GridContainer/PowerLabel
@onready var money_label: Label = $MarginContainer2/VBoxContainer/MoneyLabel

@onready var food_passive_upgrade_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FoodPassiveUpgradeButton
@onready var food_manual_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FoodManualUpgradeButton
@onready var food_storage_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FoodStorageUpgradeButton
@onready var water_passive_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/WaterPassiveUpgradeButton
@onready var water_manual_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/WaterManualUpgradeButton
@onready var water_storage_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/WaterStorageUpgradeButton
@onready var power_passive_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PowerPassiveUpgradeButton
@onready var power_manual_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PowerManualUpgradeButton
@onready var power_storage_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PowerStorageUpgradeButton

@onready var sell_food_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellFoodButton
@onready var sell_water_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellWaterButton
@onready var sell_power_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellPowerButton
@onready var sell_10_food_button: Button = $MarginContainer2/VBoxContainer/GridContainer/Sell10FoodButton
@onready var sell_all_food_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellAllFoodButton
@onready var sell_10_water_button: Button = $MarginContainer2/VBoxContainer/GridContainer/Sell10WaterButton
@onready var sell_all_water_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellAllWaterButton
@onready var sell_10_power_button: Button = $MarginContainer2/VBoxContainer/GridContainer/Sell10PowerButton
@onready var sell_all_power_button: Button = $MarginContainer2/VBoxContainer/GridContainer/SellAllPowerButton

@onready var food_faster_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FoodFasterUpgradeButton
@onready var water_faster_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/WaterFasterUpgradeButton
@onready var power_faster_upgrade_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PowerFasterUpgradeButton

@onready var double_sell_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/DoubleSellButton
@onready var halve_usage_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/HalveUsageButton

@onready var day_label: Label = $DayLabel

func _ready() -> void:
	double_sell_button.text = "Double Sell Price of Every Resource\n$" + str(int(floor(GameState.MERCHANT_UPGRADE_COST)))
	halve_usage_button.text = "Halve Usage Per Day of Every Resource\n$" + str(int(floor(GameState.HIBERNATOR_UPGRADE_COST)))
	var days_left = str(GameState.TOTAL_NUM_DAYS - GameState.current_day)
	day_label.text = days_left + " day" + ("" if days_left == "1" else "s") + "\nremain" + ("s" if days_left == "1" else "")

func set_text(button, resource, upgrade_type, amount, resource_unit, cost):
	button.text = "Upgrade " + resource + " " + upgrade_type + "\nto " + str(amount) + " " + resource_unit + "\n$" + str(int(cost))

func set_upgrade_tooltip_text(button, resource, upgrade_type, amount, resource_unit, cost):
	button.upgrade_tooltip_text = "Upgrade " + resource + " " + upgrade_type + "\nto " + str(amount) + " " + resource_unit + "\n$" + str(int(cost))


func set_button_enabled(button, upgrade_type, resource):
	if GameState.upgrades[upgrade_type][resource] == GameState.MAX_UPGRADE_LEVEL:
		button.text = "MAXED OUT"
		button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	food_label.text = "Food: " + str(int(floor(GameState.get_food()))) + " cans (" + str(int(floor(GameState.get_food_max()))) + " max)"
	water_label.text = "Water: " + str(int(floor(GameState.get_water()))) + " bottles (" + str(int(floor(GameState.get_water_max()))) + " max)"
	power_label.text = "Power: " + str(int(floor(GameState.get_power()))) + " kWh (" + str(int(floor(GameState.get_power_max()))) + " max)"
	money_label.text = "Money: $" + str(int(floor(GameState.money)))
	
	set_text(food_passive_upgrade_button, "Food", "Passive Gen", GameState.get_next_food_gen_rate(),
		"can/s", GameState.cost(GameState.Upgrades.PASSIVE_GEN, GameState.Resources.FOOD))
	set_upgrade_tooltip_text(food_passive_upgrade_button, "Food", "Passive Gen", GameState.get_next_food_gen_rate(),
		"can/s", GameState.cost(GameState.Upgrades.PASSIVE_GEN, GameState.Resources.FOOD))
	set_text(food_manual_upgrade_button, "Food", "Manual Gen", GameState.next_manual_gen_food(),
		"cans", GameState.cost(GameState.Upgrades.MANUAL_GEN, GameState.Resources.FOOD))
	set_text(food_storage_upgrade_button, "Food", "Storage", GameState.get_next_food_max(),
		"cans", GameState.cost(GameState.Upgrades.STORAGE, GameState.Resources.FOOD))
	set_text(water_passive_upgrade_button, "Water", "Passive Gen", GameState.get_next_water_gen_rate(),
		"bottle/s", GameState.cost(GameState.Upgrades.PASSIVE_GEN, GameState.Resources.WATER))
	set_text(water_manual_upgrade_button, "Water", "Manual Gen", GameState.next_manual_gen_water(),
		"bottles", GameState.cost(GameState.Upgrades.MANUAL_GEN, GameState.Resources.WATER))
	set_text(water_storage_upgrade_button, "Water", "Storage", GameState.get_next_water_max(),
		"bottles", GameState.cost(GameState.Upgrades.STORAGE, GameState.Resources.WATER))
	set_text(power_passive_upgrade_button, "Power", "Passive Gen", GameState.get_next_power_gen_rate(),
		"kWh/s", GameState.cost(GameState.Upgrades.PASSIVE_GEN, GameState.Resources.POWER))
	set_text(power_manual_upgrade_button, "Power", "Manual Gen", GameState.next_manual_gen_power(),
		"kWh", GameState.cost(GameState.Upgrades.MANUAL_GEN, GameState.Resources.POWER))
	set_text(power_storage_upgrade_button, "Power", "Storage", GameState.get_next_power_max(),
		"kWh", GameState.cost(GameState.Upgrades.STORAGE, GameState.Resources.POWER))
	set_text(food_faster_upgrade_button, "Food", "Gen Time", GameState.next_food_manual_gen_timer(),
		"s", GameState.cost(GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.FOOD))
	set_text(water_faster_upgrade_button, "Water", "Gen Time", GameState.next_water_manual_gen_timer(),
		"s", GameState.cost(GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.WATER))
	set_text(power_faster_upgrade_button, "Power", "Gen Time", GameState.next_power_manual_gen_timer(),
		"s", GameState.cost(GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.POWER))
	
	set_button_enabled(food_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.FOOD)
	set_button_enabled(food_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.FOOD)
	set_button_enabled(food_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.FOOD)
	set_button_enabled(water_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.WATER)
	set_button_enabled(water_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.WATER)
	set_button_enabled(water_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.WATER)
	set_button_enabled(power_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.POWER)
	set_button_enabled(power_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.POWER)
	set_button_enabled(power_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.POWER)
	set_button_enabled(food_faster_upgrade_button, GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.FOOD)
	set_button_enabled(water_faster_upgrade_button, GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.WATER)
	set_button_enabled(power_faster_upgrade_button, GameState.Upgrades.MANUAL_GEN_TIME, GameState.Resources.POWER)

	sell_food_button.text = " Sell 1 can for $" + str(int(floor(GameState.sell_rate(GameState.Resources.FOOD)))) + " "
	sell_water_button.text = " Sell 1 bottle for $" + str(int(floor(GameState.sell_rate(GameState.Resources.WATER)))) + " "
	sell_power_button.text = " Sell 1 kWh for $" + str(int(floor(GameState.sell_rate(GameState.Resources.POWER)))) + " "
	
	sell_10_food_button.text = " Sell 10 ($" + str(10 * int(floor(GameState.sell_rate(GameState.Resources.FOOD)))) + ") "
	sell_10_water_button.text = " Sell 10 ($" + str(10 * int(floor(GameState.sell_rate(GameState.Resources.WATER)))) + ") "
	sell_10_power_button.text = " Sell 10 ($" + str(10 * int(floor(GameState.sell_rate(GameState.Resources.POWER)))) + ") "

	sell_all_food_button.text = " Sell all ($" + str(int(floor(GameState.get_food())) * int(floor(GameState.sell_rate(GameState.Resources.FOOD)))) + ") "
	sell_all_water_button.text = " Sell all ($" + str(int(floor(GameState.get_water())) * int(floor(GameState.sell_rate(GameState.Resources.WATER)))) + ") "
	sell_all_power_button.text = " Sell all ($" + str(int(floor(GameState.get_power())) * int(floor(GameState.sell_rate(GameState.Resources.POWER)))) + ") "

	if GameState.merchant_bought:
		double_sell_button.disabled = true
		double_sell_button.text = "MAXED OUT"
		
	if GameState.hibernator_bought:
		halve_usage_button.disabled = true
		halve_usage_button.text = "MAXED OUT"

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/day-start.tscn")


func _on_sell_food_button_pressed() -> void:
	GameState.sell_food(1)

func _on_sell_water_button_pressed() -> void:
	GameState.sell_water(1)

func _on_sell_power_button_pressed() -> void:
	GameState.sell_power(1)

func _on_food_passive_upgrade_button_pressed() -> void:
	GameState.upgrade_food_passive_gen()

func _on_food_manual_upgrade_button_pressed() -> void:
	GameState.upgrade_food_manual_gen()

func _on_food_storage_upgrade_button_pressed() -> void:
	GameState.upgrade_food_storage()

func _on_water_passive_upgrade_button_pressed() -> void:
	GameState.upgrade_water_passive_gen()

func _on_water_manual_upgrade_button_pressed() -> void:
	GameState.upgrade_water_manual_gen()

func _on_water_storage_upgrade_button_pressed() -> void:
	GameState.upgrade_water_storage()

func _on_power_passive_upgrade_button_pressed() -> void:
	GameState.upgrade_power_passive_gen()

func _on_power_manual_upgrade_button_pressed() -> void:
	GameState.upgrade_power_manual_gen()

func _on_power_storage_upgrade_button_pressed() -> void:
	GameState.upgrade_power_storage()

func _on_sell_10_food_button_pressed() -> void:
	GameState.sell_food(10)

func _on_sell_all_food_button_pressed() -> void:
	GameState.sell_food(int(floor(GameState.get_food())))

func _on_sell_10_water_button_pressed() -> void:
	GameState.sell_water(10)

func _on_sell_all_water_button_pressed() -> void:
	GameState.sell_water(int(floor(GameState.get_water())))

func _on_sell_10_power_button_pressed() -> void:
	GameState.sell_power(10)

func _on_sell_all_power_button_pressed() -> void:
	GameState.sell_power(int(floor(GameState.get_power())))

func _on_food_faster_upgrade_button_pressed() -> void:
	GameState.upgrade_food_manual_gen_time()

func _on_water_faster_upgrade_button_pressed() -> void:
	GameState.upgrade_water_manual_gen_time()

func _on_power_faster_upgrade_button_pressed() -> void:
	GameState.upgrade_power_manual_gen_time()

func _on_double_sell_button_pressed() -> void:
	GameState.purchase_merchant()

func _on_halve_usage_button_pressed() -> void:
	GameState.purchase_hibernator()
