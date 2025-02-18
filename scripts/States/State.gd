extends Node
class_name State

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func ChangeState(state: String):
	pass
