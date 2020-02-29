extends PlayerState
# Move parent state for movement states[Idle,Run,Air]

const FLOOR_NORMAL = Vector2.UP
export var gravity := 20.0
export var max_fall_speed := 400
export var max_speed := 200
export var time_for_max_speed := 0.3
export var jump_force := -400


var snap_vector := Vector2(0, 32)
var velocity := Vector2.ZERO

var released_jump := false
var is_jump := false
######## Interface Methods #######


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and owner.is_on_floor():
		_state_machine.transition_to(states.air,{"jumped" : true})
	pass


func physics_process(delta: float) -> void:
	self.flip_sprite()
	velocity = self.move_with_gravity(delta,velocity)
	pass


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


######### Main Actions #########


func horizontal_movement(delta: float, old_velocity: Vector2, speed: float, direction: float, speed_time: float):
	var new_velocity := old_velocity

	if direction != 0:
		new_velocity.x += (speed / speed_time) * direction * delta
		new_velocity.x = clamp(new_velocity.x, -max_speed, max_speed)
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
	var new_gravity := velocity.y
	new_gravity += gravity
	return min(new_gravity, max_fall_speed)


func flip_sprite() -> void:
	var direction := get_move_direction() 
	if direction == -1:
		owner.get_node("Sprite").flip_h = true
	elif direction == 1:
		owner.get_node("Sprite").flip_h = false


func get_move_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
