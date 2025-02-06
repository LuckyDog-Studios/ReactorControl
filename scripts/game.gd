extends Node2D
@onready var explosion_effect: AnimationPlayer = $"Explosion Effect/AnimationPlayer"

func _ready() -> void:
	$"UI Elements/Temperature System".connect("GameOver", game_over)

func game_over():
	await get_tree().create_timer(2).timeout 
	explosion_effect.play("explosion")
	await explosion_effect.animation_finished
	get_tree().quit()

	
