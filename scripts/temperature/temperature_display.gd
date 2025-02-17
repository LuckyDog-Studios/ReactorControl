extends Node

@export var temperature_label: RichTextLabel

func update_temperature(temp, state):
	if temperature_label:
		temperature_label.text = "[center]%d°C[/center]" % int(temp)  
	update_visual_feedback(state)

func update_visual_feedback(state):
	match state:
		0:  # STABLE
			temperature_label.modulate = Color(0, 1, 0)  # Green
		1:  # WARNING
			temperature_label.modulate = Color(1, 1, 0)  # Yellow
		2:  # CRITICAL
			temperature_label.modulate = Color(1, 0.5, 0)  # Orange
		3:  # MELTDOWN
			temperature_label.modulate = Color(1, 0, 0)  # Red, flashing
		4:  # FREEZE
			temperature_label.modulate = Color(0, 0.5, 1)  # Blue
