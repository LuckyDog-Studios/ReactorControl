extends Control

# Define UI states
enum ui_states {HOME, ELECTRICITY, COOLANT, SYSTEM_BACKEND}
var current_state

# References to UI screens
@onready var home_screen: GridContainer = $"SCREEN CONTAINER/HOME SCREEN"
@onready var electricity_screen: PanelContainer = $"SCREEN CONTAINER/ELECTRICITY SCREEN"
@onready var coolant_screen: PanelContainer = $"SCREEN CONTAINER/COOLANT SCREEN"
@onready var system_backend_screen: PanelContainer = $"SCREEN CONTAINER/SYSTEM BACKEND SCREEN"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = ui_states.HOME
	update_ui()  # Ensure only the correct UI screen is visible at the start

# Function to update UI based on state
func update_ui() -> void:
	home_screen.visible = current_state == ui_states.HOME
	electricity_screen.visible = current_state == ui_states.ELECTRICITY
	coolant_screen.visible = current_state == ui_states.COOLANT
	system_backend_screen.visible = current_state == ui_states.SYSTEM_BACKEND
	
	#home button only show if not in homebutton
	$"SCREEN CONTAINER/HOME_BUTTON".visible = current_state != ui_states.HOME

# Button event functions (Connect these to buttons in the UI)

func _on_close_button_pressed() -> void:
	visible = false
	current_state = ui_states.HOME
	update_ui()

func _on_home_button_pressed() -> void:
	current_state = ui_states.HOME
	update_ui()

func _on_electricity_button_pressed() -> void:
	current_state = ui_states.ELECTRICITY
	update_ui()

func _on_coolant_button_pressed() -> void:
	current_state = ui_states.COOLANT
	update_ui()

func _on_system_backend_button_pressed() -> void:
	current_state = ui_states.SYSTEM_BACKEND
	update_ui()
