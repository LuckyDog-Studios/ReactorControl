extends State

func ChangeState(state: String):
	Transitioned.emit(self, state)
