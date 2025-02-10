extends Node2D
@onready var explosion_effect: AnimationPlayer = $"Explosion Effect/AnimationPlayer"
@onready var dialogue: Control = $"UI Elements/Dialogue"

func _ready() -> void:
	$AnimationPlayer.play("starting_sequence")
	$"UI Elements/Temperature System".connect("GameOver", game_over)

func game_over():
	await get_tree().create_timer(2).timeout 
	explosion_effect.play("explosion")
	await explosion_effect.animation_finished
	get_tree().quit()

func type_array(text_queue: Array[String], queue_names: Array[String]) -> void:
	print("Parent function called!")
	dialogue.type_array(text_queue, queue_names);
