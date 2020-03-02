extends PlayerState
# Interact state responsible for all interactions


######### Interface Methods #########

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		_state_machine.transition_to(states.idle)
	pass


func physics_process(delta: float) -> void:
	pass

func process(delta:float)->void:
	pass

func enter(msg: Dictionary = {}) -> void:
	Signals.connect("interaction_finished",self,"finish_interaction")
	Signals.emit_signal("interaction_start")
	pass


func exit() -> void:
	pass

####### Signals #######
func finish_interaction():
	if owner.velocity.x != 0.0:
		_state_machine.transition_to(states.run)
	_state_machine.transition_to(states.idle)
