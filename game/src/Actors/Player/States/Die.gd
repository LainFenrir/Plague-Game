extends PlayerState
# Interact state responsible for all interactions

######### Interface Methods #########

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)

func process(delta:float)->void:
	pass

func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()

##### Main Functions ####