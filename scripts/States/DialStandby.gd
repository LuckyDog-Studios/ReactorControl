extends State
class_name DialStandby

var sprite: Sprite2D
var turn_speed = 50

func Enter():
	sprite = get_tree().get_first_node_in_group("Dial Sprite")

func Update(delta: float):
	var current_rotation = sprite.rotation_degrees
	if current_rotation != 0:
		current_rotation = move_toward(current_rotation, 0, delta* turn_speed)
		
	sprite.rotation_degrees = current_rotation
	
	
func _on_area_2d_mouse_entered() -> void:
	Transitioned.emit(self, "Turning")
