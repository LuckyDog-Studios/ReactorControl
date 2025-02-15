extends Node2D
@onready var explosion_effect: AnimationPlayer = $"UI Elements/Explosion Effect/AnimationPlayer"
@onready var dialogue: Control = $"UI Elements/Dialogue"

func _ready() -> void:
	play_starting_sequence()
	
	if $"UI Elements/Temperature System":
		$"UI Elements/Temperature System".connect("GameOver", game_over)
		
	
	#so that I can actually see the damn viewport :)
	$"UI Elements/FadeInRectangle".visible = true
	

func game_over():
	await get_tree().create_timer(2).timeout 
	explosion_effect.play("explosion")
	await explosion_effect.animation_finished
	get_tree().quit()

func type_array(text_queue: Array[String], queue_names: Array[String]) -> void:
	dialogue.type_array(text_queue, queue_names);

func play_starting_sequence() -> void:
	$AnimationPlayer.play("starting_sequence")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("repeat warning")
	
	

func _on_dialogue_dialogue_complete() -> void:
	await get_tree().create_timer(1).timeout
	explosion_effect.play("explosion")
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.stop()
	$"UI Elements/FadeInRectangle".visible = false
	$Sounds/AlarmSoundsPlayer.stream_paused = true
