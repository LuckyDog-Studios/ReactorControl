extends Control

func _process(delta: float) -> void:
	test_escape_input()
func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func test_escape_input() -> void:
	if Input.is_action_just_pressed("PAUSE") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("PAUSE") and get_tree().paused:
		resume()


func _on_continue_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
