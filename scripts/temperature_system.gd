extends Control

@onready var label: Label = $Label
@onready var dial_sprite: Sprite2D = $"../Dial/Sprite"
@onready var timer: Timer = $Timer

@export var starting_temp: int = 150
var current_temp: int

var starting_wait_time = 0.5

func _ready() -> void:
	label.text = "Temp: " + str(starting_temp) + " C"
	current_temp = starting_temp
	timer.start()


func _on_timer_timeout() -> void:
	var current_temp = label.text.to_int()
	if dial_sprite.rotation_degrees < -0.01:  #dial is pointing left
		current_temp = move_toward(current_temp, 30, 1)
		timer.wait_time = starting_wait_time
	elif dial_sprite.rotation_degrees > 0.01:  #dial is pointing right
		current_temp = move_toward(current_temp, 200, 1)
		timer.wait_time = starting_wait_time
	else: #dial is on standby
		current_temp = move_toward(current_temp, 200, 1)
		timer.wait_time = starting_wait_time * 2  #make it tick twice as slow
		
	label.text = "Temp: " + str(current_temp) + " C"
	timer.start()
