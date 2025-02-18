extends Node

## Temperature Variables
@export var temperature_display: Node2D  # Link to TemperatureDisplay
@export var heating_system: Node       # Link to HeatingSystem
@export var cooling_system: Node       # Link to CoolingSystem
@onready var explosion_effect: AnimationPlayer = $"../../CanvasLayer/Explosion Effect/AnimationPlayer"

var current_temperature: float = 300.0
var max_safe_temperature: float = 1000.0
var min_safe_temperature: float = 100.0  # Too cold penalty
var cooling_rate: float = 0.0
var baseline_heat: float = 0.5  # Always increasing

var thermal_inertia: float = 0.05  # How slowly temp changes

enum ReactorState { STABLE, WARNING, CRITICAL, MELTDOWN, FREEZE }
var reactor_state = ReactorState.STABLE

func _process(delta):
	update_temperature(delta)
	update_reactor_state()
	update_display()

func update_temperature(delta):
	var heating = 0.0
	var cooling = 0.0
	
	
	if heating_system and heating_system.is_active:
		heating = heating_system.get_heating()
	if cooling_system and cooling_system.is_active:
		cooling = cooling_system.get_cooling()
	
	var target_temp = current_temperature + baseline_heat + heating - cooling
	current_temperature = lerp(current_temperature, target_temp, thermal_inertia)

func update_reactor_state():
	if current_temperature >= max_safe_temperature:
		reactor_state = ReactorState.MELTDOWN
		trigger_meltdown()
	elif current_temperature <= min_safe_temperature:
		reactor_state = ReactorState.FREEZE
		trigger_freeze()
	elif current_temperature >= max_safe_temperature * 0.8:
		reactor_state = ReactorState.CRITICAL
	elif current_temperature >= max_safe_temperature * 0.6:
		reactor_state = ReactorState.WARNING
	else:
		reactor_state = ReactorState.STABLE

func update_display():
	if temperature_display:
		temperature_display.update_temperature(current_temperature, reactor_state)

func trigger_meltdown():
	explosion_effect.play("explosion")
	await explosion_effect.animation_finished
	get_tree().quit()

func trigger_freeze():
	print("❄️ REACTOR TOO COLD! Systems shutting down!")
	# Disable fuel, require restart, etc.
