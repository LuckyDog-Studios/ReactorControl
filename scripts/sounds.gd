extends Node

@onready var alarm_sounds_player: AudioStreamPlayer = $AlarmSoundsPlayer



func _on_alarm_sounds_player_finished() -> void:
	alarm_sounds_player.play()
