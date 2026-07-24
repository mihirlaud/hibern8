extends Node2D

@onready var food_label: Label = $FoodLabel
@onready var water_label: Label = $WaterLabel
@onready var power_label: Label = $PowerLabel
@onready var money_label: Label = $MoneyLabel

@onready var food_passive_upgrade_button: Button = $FoodPassiveUpgradeButton
@onready var food_manual_upgrade_button: Button = $FoodManualUpgradeButton
@onready var food_storage_upgrade_button: Button = $FoodStorageUpgradeButton
@onready var water_passive_upgrade_button: Button = $WaterPassiveUpgradeButton
@onready var water_manual_upgrade_button: Button = $WaterManualUpgradeButton
@onready var water_storage_upgrade_button: Button = $WaterStorageUpgradeButton
@onready var power_passive_upgrade_button: Button = $PowerPassiveUpgradeButton
@onready var power_manual_upgrade_button: Button = $PowerManualUpgradeButton
@onready var power_storage_upgrade_button: Button = $PowerStorageUpgradeButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_text(button, resource, upgrade_type, amount, resource_unit, cost):
	button.text = "Upgrade " + resource + " " + upgrade_type + "\nto " + str(amount) + " " + resource_unit + "\n$" + str(cost)

func set_button_enabled(button, upgrade_type, resource):
	if GameState.upgrades[upgrade_type][resource] == GameState.MAX_UPGRADE_LEVEL:
		button.text = "MAXED OUT"
		button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	food_label.text = "Food: " + str(floor(GameState.get_food())) + " cans"
	water_label.text = "Water: " + str(floor(GameState.get_water())) + " bottles"
	power_label.text = "Power: " + str(floor(GameState.get_power())) + " kWh"
	money_label.text = "Money: $" + str(floor(GameState.money))
	
	set_text(food_passive_upgrade_button, "Food", "Passive Gen", GameState.get_next_food_gen_rate(),
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
	
	set_button_enabled(food_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.FOOD)
	set_button_enabled(food_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.FOOD)
	set_button_enabled(food_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.FOOD)
	set_button_enabled(water_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.WATER)
	set_button_enabled(water_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.WATER)
	set_button_enabled(water_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.WATER)
	set_button_enabled(power_passive_upgrade_button, GameState.Upgrades.PASSIVE_GEN, GameState.Resources.POWER)
	set_button_enabled(power_manual_upgrade_button, GameState.Upgrades.MANUAL_GEN, GameState.Resources.POWER)
	set_button_enabled(power_storage_upgrade_button, GameState.Upgrades.STORAGE, GameState.Resources.POWER)

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
