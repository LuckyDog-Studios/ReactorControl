extends Control


@onready var label: Label = $"CenterContainer/Label"
@onready var dial_sprite: Sprite2D = $"../../Dial/Sprite"
@onready var timer: Timer = $Timer

@export var starting_temp: int = 150
var current_temp: int

#timer's waiting time per tick
var timer_wait_time = 0.25

# flickering timer 
const FLICKERING_DELAY = 0.5 
var flickering_time = 0.0
var is_flickering = false

# color
var color_min_value = 30.0
var color_max_value = 200.0

signal GameOver()

func _process(delta: float) -> void:
	is_flickering = true if current_temp >= 160 else false
	
	#flicker code
	if is_flickering and flickering_time <= 0.0:
		flickering_time = FLICKERING_DELAY if current_temp <= 190 else FLICKERING_DELAY/2 # flicker faster when its greater than 190
		label.visible = not label.visible
	elif is_flickering:
		flickering_time -= delta
	else:
		label.visible = true
	
	label.self_modulate = get_color_from_value(current_temp)
	
	if current_temp >= 200:
		GameOver.emit()
	


func _ready() -> void:
	label.text = "Temp: " + str(starting_temp) + " C"
	current_temp = starting_temp
	timer.start()

func _on_timer_timeout() -> void:
	current_temp = label.text.to_int()
	if dial_sprite.rotation_degrees < -0.01:  #dial is pointing left
		current_temp = move_toward(current_temp, 30, 1)
		timer.wait_time = timer_wait_time
	elif dial_sprite.rotation_degrees > 0.01:  #dial is pointing right
		current_temp = move_toward(current_temp, 200, 1)
		timer.wait_time = timer_wait_time
	else: #dial is on standby
		current_temp = move_toward(current_temp, 200, 1)
		timer.wait_time = timer_wait_time * 2  #make it tick twice as slow
		
	label.text = "Temp: " + str(current_temp) + " C"
	timer.start()

func get_color_from_value(value: float) -> Color:
	
	var t = clamp((value - color_min_value) / (color_max_value - color_min_value), 0.0, 1.0) # Normalize between 0-1
	
	if t < 0.5:
		return Color.BLUE.lerp(Color.GREEN, t * 2)
	else:
		return Color.GREEN.lerp(Color.RED, (t-0.5)*2)
