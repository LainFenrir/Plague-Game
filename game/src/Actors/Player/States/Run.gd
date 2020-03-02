extends PlayerState
# Run State

######## Interface Methods #########


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	owner.velocity = _parent.horizontal_movement(delta,owner.velocity,owner.max_speed,get_move_direction())
	_parent.physics_process(delta)
	_listen_state_change()

func process(delta:float)->void:
	pass

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
		if get_move_direction() == 0.0:
			_state_machine.transition_to(states.idle)
	else:
		_state_machine.transition_to(states.air)
