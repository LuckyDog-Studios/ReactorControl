extends Node2D

var isDragging: bool = false;
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var last_animation = "idle"

func _process(delta: float) -> void:
	if last_animation == "turned_right" and not isDragging:
		animation_player.play("turned_right", -1, -1.0, true)
		await animation_player.animation_finished
		last_animation = "idle"
	elif last_animation == "turned_left" and not isDragging:
		animation_player.play("turned_left", -1, -1.0, true)
		await animation_player.animation_finished
		last_animation = "idle"
		

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("INTERACT"):
		isDragging = event.is_action_pressed("INTERACT")
		
	if isDragging:
		if get_local_mouse_position().x > 0 and last_animation != "turned_right":
			animation_player.play("turned_right")
			last_animation = "turned_right"
		elif get_local_mouse_position().x <= 0 and last_animation != "turned_left": 
			animation_player.play("turned_left")
			last_animation = "turned_left"


func _on_area_2d_mouse_exited() -> void:
	isDragging = false
