extends Node

@onready var timer: Timer = $Timer

var all_events: Dictionary = {}

func _ready() -> void:
	for node in get_children():
		if node is RandomEvent:
			all_events[node.name.to_lower()] = node


# roll dice to add effects - every 1s (changeable)
func _on_timer_timeout() -> void:
	for event_name in all_events:
		var event = all_events[event_name]
		if event.roll_dice():
			event.apply_effect()
	
