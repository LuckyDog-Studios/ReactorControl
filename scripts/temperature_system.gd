extends Control

@onready var label: Label = $Label

var current_temp: float = 150.0

func _ready() -> void:
	label.text = "Temp: " + str(current_temp) + " C"


func _on_timer_timeout() -> void:
	print(current_temp)
	var dial = get_node("/root/Game/Dial")
	
	current_temp = float(label.text.substr(5, 4))
	if dial.last_animation == "idle":
		current_temp = move_toward(current_temp, 200, 1)
	elif dial.last_animation == "turned_left":
		current_temp = move_toward(current_temp, 30.0, 1)
	elif dial.last_animation == "turned_right":
		current_temp = move_toward(current_temp, 200.0, 2)
		
	label.text = "Temp: " + str(current_temp) + " C"
