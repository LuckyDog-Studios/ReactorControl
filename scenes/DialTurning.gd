extends State

var sprite: Sprite2D
var area2d: Area2D
var turn_speed = 200

func Enter():
	sprite = get_tree().get_first_node_in_group("Dial Sprite")
	area2d = get_tree().get_first_node_in_group("Dial Area2d")

func Update(delta: float):
	var current_rotation = sprite.rotation_degrees
	if sprite.get_local_mouse_position().x > 0:
		current_rotation = move_toward(current_rotation, 90, delta*turn_speed)
	else:
		current_rotation = move_toward(current_rotation, -90, delta*turn_speed)
		
	
	sprite.rotation_degrees = current_rotation

func _on_area_2d_mouse_exited() -> void:
	Transitioned.emit(self, "Standby")
