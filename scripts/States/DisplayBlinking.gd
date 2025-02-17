extends State
@export var label: RichTextLabel
var blink_time = 1
var current_time = 0.0

func Enter() -> void:
	pass
	
func Exit() -> void:
	label.visible = true

func Update(delta: float) -> void:
	current_time += delta
	if current_time >= blink_time:
		label.visible = not label.visible
		current_time = 0.0
