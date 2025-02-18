extends Node2D

var is_open: bool = false
@export var side_screen_ui: Control

var wait_time: float = 0.1
var curr_time: float = 0.0

# Movement speeds for sliding the panel
var slide_speed_open: float = 850
var slide_speed_close: float = 300
var target_x: float = 0.0  # Position to slide the panel to (open or closed)

# Reference to nodes
@onready var animated_sprite = $AnimatedSprite2D
@onready var open_close_area = $OpenCloseArea2D

func _process(delta: float) -> void:
	curr_time += delta
	# Check if the panel is open and move accordingly
	if is_open:
		target_x = -230  # Open position (off-screen)
	else:
		target_x = 0  # Closed position (on-screen)

	# Smooth movement towards the target X position
	move_panel(delta)

func move_panel(delta: float) -> void:
	# Move both the panel and the interaction area
	var move_speed = slide_speed_open if is_open else slide_speed_close
	animated_sprite.position.x = move_toward(animated_sprite.position.x, target_x, move_speed * delta)
	open_close_area.position.x = move_toward(open_close_area.position.x, target_x, move_speed * delta)

func _on_area_2d_mouse_entered() -> void:
	if curr_time >= wait_time:
		toggle_panel()
		curr_time = 0.0

func _on_open_close_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		side_screen_ui.visible = true

# Toggles the panel state
func toggle_panel() -> void:
	is_open = !is_open
