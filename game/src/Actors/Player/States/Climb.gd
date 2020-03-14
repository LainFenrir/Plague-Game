extends PlayerState





#### Interface Methods ####
func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_state_machine.transition_to(states.air, {"jumped": true})
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	#_parent.physics_process(delta)
	owner.velocity = climb(delta, owner.velocity, owner.climb_speed, get_vertical_direction())
	owner.velocity = _parent.move_no_gravity(delta,owner.velocity)
	

func process(delta: float) -> void:
	self.stop_climbing()
	pass


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	is_climbing = true
	# Signals.emit_signal("toggle_plataform",true,ladder_dir)
	var new_pos := Vector2(ladder_position.x,owner.get_global_position().y)
	if owner.ray_plataform.is_colliding():
		new_pos.y = owner.position.y +2
	owner.set_global_position(new_pos)
#	Signals.connect("is_climbing", self, "stop_climbing")


func exit() -> void:
	is_climbing = false
	_parent.exit()

##### Main Functions ####
func climb(delta: float, old_velocity: Vector2, speed: float, direction: float)->Vector2:
	var new_velocity := old_velocity
	new_velocity.x = 0
	if direction != 0:
		new_velocity.y += speed * direction
		new_velocity.y = clamp(new_velocity.y, -owner.climb_speed, owner.climb_speed)
	else:
		new_velocity.y = 0
	return new_velocity

####### Signals #######
func stop_climbing()->void :
# TODO: if still inside box press the oposite direction to get out
	if  will_drop and Input.is_action_pressed("move_down"):
		_state_machine.transition_to(states.air)
	if not can_climb:
		_state_machine.transition_to(states.air)
	# if owner.raycast.is_colliding():
	# 	_state_machine.transition_to(states.air)
	# if value == false and owner.is_on_floor():
	# 	if owner.velocity.x != 0.0:
	# 		_state_machine.transition_to(states.run)
	# 	_state_machine.transition_to(states.idle)
	# else:
	# 	_state_machine.transition_to(states.air)
