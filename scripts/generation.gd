extends Node2D

@onready var timer_label: Label = $TimerLabel
@onready var day_timer: Timer = $DayTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_timer.wait_time = GameState.DAY_LENGTH_IN_S
	day_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = str(round(day_timer.time_left * 10) / 10.0) + " s"

func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/day-end.tscn")
