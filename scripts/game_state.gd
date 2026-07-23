extends Node

const TOTAL_NUM_DAYS = 5
const DAY_LENGTH_IN_S = 60.0
const INITIAL_MAX_FOOD = 10.0
const INITIAL_MAX_WATER = 10.0
const INITIAL_MAX_POWER = 10.0
const INITIAL_MANUAL_FOOD_GEN_TIME = 5.0
const INITIAL_MANUAL_WATER_GEN_TIME = 5.0
const INITIAL_MANUAL_POWER_GEN_TIME = 5.0
const INITIAL_MANUAL_FOOD_GEN = 1.0
const INITIAL_MANUAL_WATER_GEN = 1.0
const INITIAL_MANUAL_POWER_GEN = 1.0
const FOOD_SELL_RATE = 5.0
const WATER_SELL_RATE = 10.0
const POWER_SELL_RATE = 2.0

var current_day = 0
var food = 0.0
var water = 0.0
var power = 0.0
var money = 0.0
var food_gen = 0.0
var water_gen = 0.0
var power_gen = 0.0
var manual_food_gen = INITIAL_MANUAL_FOOD_GEN
var manual_water_gen = INITIAL_MANUAL_WATER_GEN
var manual_power_gen = INITIAL_MANUAL_POWER_GEN
var manual_food_gen_timer = INITIAL_MANUAL_FOOD_GEN_TIME
var manual_water_gen_timer = INITIAL_MANUAL_WATER_GEN_TIME
var manual_power_gen_timer = INITIAL_MANUAL_POWER_GEN_TIME
var max_food = INITIAL_MAX_FOOD
var max_water = INITIAL_MAX_WATER
var max_power = INITIAL_MAX_POWER

func init_game():
	current_day = 0
	food = 0.0
	water = 0.0
	power = 0.0
	food_gen = 0.0
	water_gen = 0.0
	power_gen = 0.0
	manual_food_gen = INITIAL_MANUAL_FOOD_GEN
	manual_water_gen = INITIAL_MANUAL_WATER_GEN
	manual_power_gen = INITIAL_MANUAL_POWER_GEN
	manual_food_gen_timer = INITIAL_MANUAL_FOOD_GEN_TIME
	manual_water_gen_timer = INITIAL_MANUAL_WATER_GEN_TIME
	manual_power_gen_timer = INITIAL_MANUAL_POWER_GEN_TIME
	max_food = INITIAL_MAX_FOOD
	max_water = INITIAL_MAX_WATER
	max_power = INITIAL_MAX_POWER

func start_day():
	current_day += 1
	
func run_gen(delta):
	food += food_gen * delta
	water += water_gen * delta
	power += power_gen * delta

	food = min(max_food, food)
	water = min(max_water, water)
	power = min(max_power, power)

func sell_food(quantity):
	food -= quantity
	money += quantity * FOOD_SELL_RATE

func sell_water(quantity):
	water -= quantity
	money += quantity * WATER_SELL_RATE
	
func sell_power(quantity):
	power -= quantity
	money += quantity * POWER_SELL_RATE
