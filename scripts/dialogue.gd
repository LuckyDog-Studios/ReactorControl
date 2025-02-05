
extends Control

@onready var text: RichTextLabel = $RichTextLabel
const letter_delay = 0.1


func type_text(line: String) -> void:
	for c in line:
		text.add_text(c)
		await get_tree().create_timer(letter_delay).timeout 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type_text("Hello there! I'm your robot assistant.");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
		
