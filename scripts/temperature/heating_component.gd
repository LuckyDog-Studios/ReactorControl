extends Node

var fuel_input: float = 1.0  # Changes based on player settings
var is_active: bool = false

func get_heating():
	return fuel_input * 5.0  # Scales heat production

func toggle_active():
	is_active = not is_active
