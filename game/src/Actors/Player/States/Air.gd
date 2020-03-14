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
	if owner.velocity.y <= 0:
		self._listen_state_change()
	if owner.air_move:
		owner.velocity = _parent.horizontal_movement(delta,owner.velocity,owner.jump_horizontal_speed,get_move_direction())

	_parent.physics_process(delta)

func process(delta:float)->void:
	pass

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
	new_velocity = owner.jump_force
	owner.velocity.y = new_velocity
	is_jumping = false

	


func fall(delta: float):
	var new_velocity :float 
	if released_jump:
		if owner.velocity.y <0: 
			new_velocity = 0.0
			owner.velocity.y = new_velocity
		released_jump=false



func _listen_state_change() -> void:
	if owner.is_on_floor():
		var target_state: String = states.idle if get_move_direction() == 0.0 else states.run
		_state_machine.transition_to(target_state)
