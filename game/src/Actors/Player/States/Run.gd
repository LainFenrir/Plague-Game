extends PlayerState
# Run State

######## Interface Methods #########


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_listen_state_change()
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()


########## Main Methods #############	


func _listen_state_change() -> void:
	if owner.is_on_floor():
		if _parent.get_move_direction() == 0.0:
			_state_machine.transition_to(states.idle)
	else:
		_state_machine.transition_to(states.air)
