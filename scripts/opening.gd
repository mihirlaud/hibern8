extends Control

@onready var rich_text_label: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel
@onready var rich_text_label_2: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel2
@onready var rich_text_label_3: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel3
@onready var rich_text_label_4: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel4
@onready var rich_text_label_5: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel5

const DISPLAY_TIME_IN_S = 3.0
const WAIT_TIME_IN_S = 2.0
const POEM_1 = "O WERE my Love yon lilac fair, \n   Wi' purple blossoms to the spring,"
const POEM_2 = "And I a bird to shelter there, \n   When wearied on my little wing;  "
const POEM_3  = "How I wad mourn when it was torn  \n   By autumn wild and [b]winter[/b] rude!  "
const POEM_3A = "                                  \n                      [b]winter[/b]"
const POEM_4 = "But I wad sing on wanton wing  \n   When youthfu' May its bloom renew'd.  "
const POEM_5 = "\n                      -- Robert Burns  "

var elapsed_time = 0.0
var labels = [rich_text_label, rich_text_label_2, rich_text_label_3, rich_text_label_4, rich_text_label_5]
var current_label = 0
var waiting = false
var wait_start = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	elapsed_time = 0.0
	rich_text_label.text = POEM_1
	rich_text_label.visible_ratio = 0.0
	rich_text_label_2.text = POEM_2
	rich_text_label_2.visible_ratio = 0.0
	rich_text_label_3.text = POEM_3
	rich_text_label_3.visible_ratio = 0.0
	rich_text_label_4.text = POEM_4
	rich_text_label_4.visible_ratio = 0.0
	rich_text_label_5.text = POEM_5
	rich_text_label_5.visible_ratio = 0.0
	current_label = 0
	labels = [rich_text_label, rich_text_label_2, rich_text_label_3, rich_text_label_4, rich_text_label_5]
	waiting = false
	wait_start = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if current_label == -1:
		rich_text_label.text = ""
		rich_text_label_2.text = ""
		rich_text_label_3.text = POEM_3A
		rich_text_label_4.text = ""
		rich_text_label_5.text = ""
	
	if current_label == -2:
		get_tree().change_scene_to_file("res://scenes/start.tscn")
	
	if current_label >= 0 and current_label < len(labels):
		if labels[current_label].visible_ratio == 1.0:
			if not waiting:
				waiting = true
				wait_start = elapsed_time
			else:
				if elapsed_time - wait_start >= WAIT_TIME_IN_S:
					waiting = false
					current_label += 1
		else:
			var prev_vis_char = labels[current_label].visible_characters
			labels[current_label].visible_ratio = min(1.0, (elapsed_time - current_label * (DISPLAY_TIME_IN_S + WAIT_TIME_IN_S)) / DISPLAY_TIME_IN_S)
			var new_vis_char = labels[current_label].visible_characters
	
			if prev_vis_char != new_vis_char:
				Audio.play_blop()
	else:
		if not waiting:
			waiting = true
			wait_start = elapsed_time
		else:
			if elapsed_time - wait_start >= WAIT_TIME_IN_S:
				waiting = false
				if current_label > 0:
					current_label = -1
				else:
					current_label = -2
