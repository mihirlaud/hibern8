extends Button

@export var upgrade_tooltip_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltip = preload("res://scenes/tooltip.tscn").instantiate()
	tooltip.get_node("PanelContainer/Label").text = upgrade_tooltip_text
	return tooltip
