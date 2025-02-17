extends Node

var cooling_power: float = 2.0  # Base cooling power
var is_active: bool = false

func get_cooling():
	return cooling_power

func toggle_active():
	is_active = not is_active
