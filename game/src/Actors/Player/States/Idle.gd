extends PlayerState
# Idle State

######## Interface Methods #########


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	idle_around()
	_listen_state_change()
	_parent.physics_process(delta)

func process(delta:float)->void:
	pass

func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()


######### Main Actions #########

func idle_around():
	#TODO:REFACTOR ACTIONS TO BE CONFINED IN THEIR STATES
	owner.velocity.x = 0.0 


func _listen_state_change() -> void:
	if owner.is_on_floor() and get_move_direction() != 0.0:
		_state_machine.transition_to(states.run)
	elif not owner.is_on_floor():
		_state_machine.transition_to(states.air)
