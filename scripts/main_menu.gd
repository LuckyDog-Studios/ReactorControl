extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func _on_start_button_pressed() -> void:
	$AnimationPlayer.play("start")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/startingsequence.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
