extends PlayerState
# Move parent state for movement states[Idle,Run,Air]

const FLOOR_NORMAL = Vector2.UP



var snap_vector := Vector2(0, 32)

var released_jump := false
var is_jump := false
######## Interface Methods #######


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and owner.is_on_floor():
		_state_machine.transition_to(states.air,{"jumped" : true})
	if event.is_action_pressed("interact") and is_interactable and owner.is_on_floor():
		_state_machine.transition_to(states.interact)
	pass


func physics_process(delta: float) -> void:
	self.flip_sprite()
	owner.velocity = self.move_with_gravity(delta,owner.velocity)
	pass

func process(delta:float)->void:
	pass

func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


######### Main Actions #########


func horizontal_movement(delta: float, old_velocity: Vector2, speed: float, direction: float):
	var new_velocity := old_velocity

	if direction != 0:
		new_velocity.x += speed  * direction 
		new_velocity.x = clamp(new_velocity.x, -owner.max_speed, owner.max_speed)
	else:
		new_velocity.x = 0
	return new_velocity

func move_with_gravity(delta:float,vel: Vector2) -> Vector2:
	vel.y = set_gravity(delta)
	return owner.move_and_slide(vel, FLOOR_NORMAL)


func move_no_gravity(delta:float,vel: Vector2) -> Vector2:
	return owner.move_and_slide(vel, FLOOR_NORMAL)
	

########## Utilities #############
func set_gravity(delta:float) -> float:
	var new_gravity :float= owner.velocity.y
	new_gravity += owner.gravity
	return min(new_gravity, owner.max_fall_speed)


func flip_sprite() -> void:
	var direction := get_move_direction() 
	if direction == -1:
		owner.get_node("Sprite").flip_h = true
	elif direction == 1:
		owner.get_node("Sprite").flip_h = false

