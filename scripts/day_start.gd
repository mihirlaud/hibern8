extends Control

@onready var label: RichTextLabel = $VBoxContainer/VBoxContainer/Label
@onready var start_button: Button = $VBoxContainer/VBoxContainer/StartButton

const DISPLAY_TIME_IN_S = 5.0
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	elapsed_time = 0.0
	GameState.start_day()
	var days_left = str(GameState.TOTAL_NUM_DAYS - GameState.current_day + 1)
	label.text = "Day [b]" + str(GameState.current_day) + "[/b] begins\n\n[b]" + days_left
	if days_left == "1":
		label.text += "[/b] day remains.\n"
	else:
		label.text += "[/b] days remain.\n"
	label.visible_ratio = 0.0
	start_button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	label.visible_ratio = min(1.0, elapsed_time / DISPLAY_TIME_IN_S)
	if elapsed_time >= DISPLAY_TIME_IN_S:
		start_button.disabled = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/generation.tscn")
