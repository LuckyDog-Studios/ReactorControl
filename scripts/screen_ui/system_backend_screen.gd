extends PanelContainer

# This code works by mirroring (line-by-line) user input onto a richtextlabel node
# Everytime a command is submitted its stored into a String which is displayed on every text change 

@onready var text_edit: TextEdit = $TextEdit
@onready var command_prompt: RichTextLabel = $RichTextLabel


const PROMPT: String = "> "         # The prompt text
var history_text: String = ""         # Stores submitted command history

func _enter_state():
	#so that i can have a starting output to the user
	type_text("testing testing 123 123")
	
	text_edit.text = PROMPT
	text_edit.set_caret_column(text_edit.text.length())

	
#Dynamically displays characters typed onto the command_prompt
func _on_text_edit_text_changed() -> void:
	# Prevent the user from deleting the prompt.
	if text_edit.text.length() < PROMPT.length():
		text_edit.text = PROMPT
		text_edit.set_caret_column(text_edit.text.length())
	update_display_input()

#deals with certain keycodes, like ENTER and BACKSPACE
func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			submit_command()
			get_viewport().set_input_as_handled()
		elif event.keycode == KEY_BACKSPACE:
			# Prevent user from deleting the prompt.
			if text_edit.get_caret_column() <= PROMPT.length():
				get_viewport().set_input_as_handled()

#extracts command and processes it aswell as starts a new line
func submit_command() -> void:
	# Get the command by stripping off the prompt.
	var command: String = text_edit.text.substr(PROMPT.length()).strip_edges()
	
	if command.length() == 0:	#deny empty commands
		return
	
	#append to history
	history_text += "\n" + PROMPT + command if not history_text.is_empty() else PROMPT + command
	
	#deal with commands here
	process_command(command)
	
	# Reset the TextEdit for the next command.
	text_edit.text = PROMPT
	text_edit.set_caret_column(text_edit.text.length())
	update_display_input()


#Updates display dynamically for each character typed as well as when submitted commands
func update_display_input() -> void:
	# The command history display is the accumulated history plus the current line.
	command_prompt.text = text_edit.text if history_text.is_empty() else history_text + "\n" + text_edit.text
	command_prompt.scroll_to_line(command_prompt.get_line_count())

func update_display_output() -> void:
	command_prompt.text = history_text
	command_prompt.scroll_to_line(command_prompt.get_line_count())


# types responses back to the user
func type_text(text: String, delayed_typing: bool = false):
	text_edit.editable = false
	command_prompt.text += "\n"
	
	if delayed_typing:
		var temp_text = ""
		for character in text:
			temp_text += character
			command_prompt.text = history_text + "\n" + temp_text  # Live update
			await get_tree().create_timer(0.05).timeout
	
	# Once typing is done, add update the history
	history_text += "\n" + text
	text_edit.editable = true
	
	update_display_output()

#processes comand text into args and what not for flexibility
func process_command(command: String) -> void:
	var tokens = command.split(" ", false)
	var cmd_name = tokens[0]
	var args = tokens.slice(1, tokens.size())  # Everything after the first word is an argument
	
	execute_command(cmd_name, args)

#does the specific action based on the command
func execute_command(cmd_name: String, args: Array) -> void:
	match cmd_name:
		"help":
			var output = "Available commands:\n"
			for command in available_commands:
				output += command + "\n"
			type_text(output.left(-1)) #removes last \n
		"clear":
			history_text = ""
		"system":
			if args.is_empty():
				type_text("Flags:\nrestart\nshutdown\nshutdownall")
		_:
			type_text("Unknown command: " + cmd_name)
			
	update_display_output()

#so its out of the way
var available_commands = ["help", "clear", "system"]
