extends PlayerState
# Run State

######## Interface Methods #########


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.velocity = _parent.horizontal_movement(delta,_parent.velocity,_parent.max_speed,_parent.get_move_direction(),_parent.time_for_max_speed)
	_parent.physics_process(delta)
	_listen_state_change()


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()


########## Main Methods #############	

func run():
	#TODO:REFACTOR ACTIONS TO BE CONFINED IN THEIR STATES
	pass
	
func _listen_state_change() -> void:
	if owner.is_on_floor():
		if _parent.get_move_direction() == 0.0:
			_state_machine.transition_to(states.idle)
	else:
		_state_machine.transition_to(states.air)
