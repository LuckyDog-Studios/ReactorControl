extends Control

func _process(delta: float) -> void:
	test_escape_input()

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	set_mouse_filter_recursive(self, Control.MOUSE_FILTER_IGNORE)


func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	set_mouse_filter_recursive(self, Control.MOUSE_FILTER_IGNORE)

func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	set_mouse_filter_recursive(self, Control.MOUSE_FILTER_STOP)
	
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

# Helper function to set mouse_filter on all UI elements recursively
func set_mouse_filter_recursive(node: Node, filter_value: int) -> void:
	if node is Control:
		node.mouse_filter = filter_value
	for child in node.get_children():
		set_mouse_filter_recursive(child, filter_value)
