extends PlayerState
# Air state for jump and fall actions

var is_jumping :=false
var released_jump:=false


######## Interface Methods #########


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		released_jump = true
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if is_jumping:
		self.jump(delta)
	self.fall(delta)
	if _parent.velocity.y <= 0:
		self._listen_state_change()

	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)

	if "jumped" in msg :
		is_jumping = true


func exit() -> void:
	_parent.exit()
	released_jump = false


######### Main Actions #########


func jump(delta: float):
	var new_velocity :float 
	new_velocity = _parent.jump_force
	_parent.velocity.y = new_velocity
	is_jumping = false

	


func fall(delta: float):
	var new_velocity :float 
	if released_jump:
		if _parent.velocity.y <0: 
			new_velocity = 0.0
			_parent.velocity.y = new_velocity
		released_jump=false



func _listen_state_change() -> void:
	if owner.is_on_floor():
		var target_state: String = states.idle if _parent.get_move_direction() == 0.0 else states.run
		_state_machine.transition_to(target_state)
