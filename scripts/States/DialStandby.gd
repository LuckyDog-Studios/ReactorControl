extends State
class_name DialStandby

var sprite: Sprite2D
var turn_speed = 50
var heating_system: Node
var cooling_system: Node

func _ready() -> void:
	heating_system = get_tree().current_scene.find_child("HeatingComponent", true, false)
	cooling_system = get_tree().current_scene.find_child("CoolingComponent", true, false)

func Enter():
	
	sprite = get_tree().get_first_node_in_group("Dial Sprite")

func Update(delta: float):
	var current_rotation = sprite.rotation_degrees
	if current_rotation != 0:
		current_rotation = move_toward(current_rotation, 0, delta* turn_speed)
		
	sprite.rotation_degrees = current_rotation
	
	if heating_system.is_active or cooling_system.is_active:
		transition_state()

func transition_state() -> void:
	Transitioned.emit(self, "Turning")
