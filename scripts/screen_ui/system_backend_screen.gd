extends PanelContainer

# This code works by mirroring (line-by-line) user input onto a richtextlabel node
# Everytime a command is submitted its stored into a String which is displayed on every text change 

@onready var text_edit: TextEdit = $TextEdit
@onready var command_history: RichTextLabel = $RichTextLabel

const PROMPT: String = "> "         # The prompt text
var history_text: String = ""         # Stores submitted command history

func _ready() -> void:
	# Initialize the TextEdit with the prompt.
	text_edit.text = PROMPT
	text_edit.set_caret_column(text_edit.text.length())
	command_history.text = text_edit.text
func _on_text_edit_text_changed() -> void:
	# Prevent the user from deleting the prompt.
	if text_edit.text.length() < PROMPT.length():
		text_edit.text = PROMPT
		text_edit.set_caret_column(text_edit.text.length())
	update_display()

func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			submit_command()
			get_viewport().set_input_as_handled()
		elif event.keycode == KEY_BACKSPACE:
			# Prevent user from deleting the prompt.
			if text_edit.get_caret_column() <= PROMPT.length():
				get_viewport().set_input_as_handled()

func submit_command() -> void:
	# Get the command by stripping off the prompt.
	var command: String = text_edit.text.substr(PROMPT.length()).strip_edges()
	
	if command.length() == 0:	#deny empty commands
		return
	
	#append to history
	history_text += "\n" + PROMPT + command if not history_text.is_empty() else PROMPT + command
	
	#deal with commands here
	await type_text("testing testing")
	
	
	# Reset the TextEdit for the next command.
	text_edit.text = PROMPT
	text_edit.set_caret_column(text_edit.text.length())
	update_display()


#DISPLAYS CURRENT TYPING FOR CURRENT LINE
func update_display() -> void:
	# The command history display is the accumulated history plus the current line.
	command_history.text = text_edit.text if history_text.is_empty() else history_text + "\n" + text_edit.text
	command_history.scroll_to_line(command_history.get_line_count())
	
	print(history_text)

#types responses back to the user
func type_text(text: String, char_delay: float = 0.1):
	text_edit.editable = false
	history_text += "\n" + text
	command_history.text += "\n"
	for char in text:
		command_history.add_text(char)
		await get_tree().create_timer(char_delay).timeout
	text_edit.editable = true
