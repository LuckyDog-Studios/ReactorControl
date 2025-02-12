extends Control

@onready var text: RichTextLabel = $"MarginContainer/RichTextLabel"
var letter_delay = 0.05
@export var test_text_queue: Array[String] = ["Testimg testing...", "Andrew is a funny guy"]
@export var test_queue_names: Array[String] = ["noah", "gyorgy"]

signal DialogueComplete

func type_text(line: String, speaker: String) -> void:
	text.clear()
	text.add_text(speaker + ": ")
	for c in line:
		text.add_text(c)
		await get_tree().create_timer(letter_delay).timeout 
		

func yield_until_space_pressed() -> void:
	while not Input.is_action_just_pressed("SPACE"):
		await get_tree().process_frame

func type_array(text_queue: Array[String], queue_names: Array[String]) -> void:
	if text_queue.is_empty():
		return
	print("FUNCITON RECIEVED")
	print(text_queue)
	
	$AnimationPlayer.play("appear")
	for i in range(min(text_queue.size(), queue_names.size())):
		await type_text(text_queue[i], queue_names[i])
		await yield_until_space_pressed()
	$AnimationPlayer.play_backwards("appear")
	
	DialogueComplete.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("SPACE"):
		letter_delay = 0.01
	else:
		letter_delay = 0.05
