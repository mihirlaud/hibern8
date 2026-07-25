extends Node

enum Resources {
	FOOD = 0,
	WATER = 1,
	POWER = 2,
	NUM_RESOURCES
}

enum Upgrades {
	PASSIVE_GEN = 0,
	MANUAL_GEN = 1,
	STORAGE = 2,
}

const TOTAL_NUM_DAYS = 2
const DAY_LENGTH_IN_S = 10.0
const INITIAL_MANUAL_GEN_TIMES: Array = [5.0, 5.0, 5.0]
const INITIAL_SELL_RATES = [5.0, 10.0, 2.0]
const MAX_UPGRADE_LEVEL = 10
const UPGRADE_COSTS = [15.0, 25.0, 10.0]

var current_day = 0
var resources = [0.0, 0.0, 0.0]
var money = 0.0
var manual_gen_timers = INITIAL_MANUAL_GEN_TIMES
var sell_rates = INITIAL_SELL_RATES
var resource_generating = [false, false, false]
var upgrades = [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1]
]

func init_game():
	current_day = 0
	resources = [0.0, 0.0, 0.0]
	money = 0.0
	manual_gen_timers = INITIAL_MANUAL_GEN_TIMES
	sell_rates = INITIAL_SELL_RATES
	resource_generating = [false, false, false]
	upgrades = [
		[1, 1, 1],
		[1, 1, 1],
		[1, 1, 1]
	]

func start_day():
	current_day += 1
	resource_generating = [false, false, false]

func gen_rate(resource) -> float:
	return (upgrades[Upgrades.PASSIVE_GEN][resource] - 1) * 2

func next_gen_rate(resource) -> float:
	return (upgrades[Upgrades.PASSIVE_GEN][resource]) * 2

func storage(resource) -> float:
	return 25 * pow(2, upgrades[Upgrades.STORAGE][resource] - 1)

func next_storage(resource) -> float:
	return 25 * pow(2, upgrades[Upgrades.STORAGE][resource])

func manual_gen_rate(resource) -> float:
	return upgrades[Upgrades.MANUAL_GEN][resource]

func next_manual_gen_rate(resource) -> float:
	return upgrades[Upgrades.MANUAL_GEN][resource] + 1

func run_gen(delta):
	for resource in range(Resources.NUM_RESOURCES):
		resources[resource] += gen_rate(resource) * delta
		resources[resource] = min(storage(resource), resources[resource])

func sell_resource(resource, quantity):
	if resources[resource] >= quantity:
		resources[resource] -= quantity
		money += quantity * sell_rates[resource]

func sell_food(quantity):
	sell_resource(Resources.FOOD, quantity)

func sell_water(quantity):
	sell_resource(Resources.WATER, quantity)
	
func sell_power(quantity):
	sell_resource(Resources.POWER, quantity)

func get_resource(resource) -> float:
	return resources[resource]

func get_food() -> float:
	return get_resource(Resources.FOOD)

func get_water() -> float:
	return get_resource(Resources.WATER)

func get_power() -> float:
	return get_resource(Resources.POWER)

func get_resource_max(resource) -> float:
	return storage(resource)

func get_food_max() -> float:
	return get_resource_max(Resources.FOOD)

func get_water_max() -> float:
	return get_resource_max(Resources.WATER)

func get_power_max() -> float:
	return get_resource_max(Resources.POWER)
	
func get_next_food_max() -> float:
	return next_storage(Resources.FOOD)

func get_next_water_max() -> float:
	return next_storage(Resources.WATER)

func get_next_power_max() -> float:
	return next_storage(Resources.POWER)

func get_next_food_gen_rate() -> float:
	return next_gen_rate(Resources.FOOD)

func get_next_water_gen_rate() -> float:
	return next_gen_rate(Resources.WATER)

func get_next_power_gen_rate() -> float:
	return next_gen_rate(Resources.POWER)

func is_resource_generating(resource) -> bool:
	return resource_generating[resource]

func is_food_generating() -> bool:
	return is_resource_generating(Resources.FOOD)
	
func is_water_generating() -> bool:
	return is_resource_generating(Resources.WATER)
	
func is_power_generating() -> bool:
	return is_resource_generating(Resources.POWER)
	
func set_resource_generating(resource, value: bool):
	resource_generating[resource] = value

func set_food_generating(value: bool):
	set_resource_generating(Resources.FOOD, value)
	
func set_water_generating(value: bool):
	set_resource_generating(Resources.WATER, value)
	
func set_power_generating(value: bool):
	set_resource_generating(Resources.POWER, value)

func manual_gen(resource):
	resources[resource] += manual_gen_rate(resource)

func manual_gen_food():
	manual_gen(Resources.FOOD)

func manual_gen_water():
	manual_gen(Resources.WATER)
	
func manual_gen_power():
	manual_gen(Resources.POWER)

func next_manual_gen_food() -> float:
	return next_manual_gen_rate(Resources.FOOD)

func next_manual_gen_water() -> float:
	return next_manual_gen_rate(Resources.WATER)
	
func next_manual_gen_power() -> float:
	return next_manual_gen_rate(Resources.POWER)

func timer(resource) -> float:
	return manual_gen_timers[resource]

func food_timer() -> float:
	return timer(Resources.FOOD)

func water_timer() -> float:
	return timer(Resources.WATER)

func power_timer() -> float:
	return timer(Resources.POWER)

func cost(upgrade_type, resource) -> float:
	return UPGRADE_COSTS[upgrade_type] * upgrades[upgrade_type][resource]
	
func upgrade(upgrade_type, resource):
	if money >= cost(upgrade_type, resource):
		if upgrades[upgrade_type][resource] < MAX_UPGRADE_LEVEL:
			money -= cost(upgrade_type, resource)
			upgrades[upgrade_type][resource] += 1

func upgrade_passive_gen(resource):
	upgrade(Upgrades.PASSIVE_GEN, resource)

func upgrade_food_passive_gen():
	upgrade_passive_gen(Resources.FOOD)

func upgrade_water_passive_gen():
	upgrade_passive_gen(Resources.WATER)
	
func upgrade_power_passive_gen():
	upgrade_passive_gen(Resources.POWER)

func upgrade_manual_gen(resource):
	upgrade(Upgrades.MANUAL_GEN, resource)

func upgrade_food_manual_gen():
	upgrade_manual_gen(Resources.FOOD)

func upgrade_water_manual_gen():
	upgrade_manual_gen(Resources.WATER)
	
func upgrade_power_manual_gen():
	upgrade_manual_gen(Resources.POWER)
	
func upgrade_storage(resource):
	upgrade(Upgrades.STORAGE, resource)

func upgrade_food_storage():
	upgrade_storage(Resources.FOOD)

func upgrade_water_storage():
	upgrade_storage(Resources.WATER)
	
func upgrade_power_storage():
	upgrade_storage(Resources.POWER)
