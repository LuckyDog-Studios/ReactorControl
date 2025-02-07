extends Control

@onready var text: RichTextLabel = $"MarginContainer/RichTextLabel"
var letter_delay = 0.05
@export var text_queue: Array[String] = []

func type_text(line: String) -> void:
	text.clear()
	for c in line:
		text.add_text(c)
		await get_tree().create_timer(letter_delay).timeout 
		

func yield_until_space_pressed() -> void:
	while not Input.is_action_just_pressed("SPACE"):
		await get_tree().process_frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for line in text_queue:
		await type_text(line)
		await yield_until_space_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("SPACE"):
		letter_delay = 0.01
	else:
		letter_delay = 0.05
