class_name RandomEvent extends Node

signal EffectEnded

func apply_effect() -> void:
	pass
	

func get_roll(numerator: int, denominator: int) -> bool:
	var random_number = randi() % denominator + 1
	
	if random_number <= numerator:
		return true
	return false

func apply_cooldown() -> void:
	pass 
