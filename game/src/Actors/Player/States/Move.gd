extends PlayerState
# Move parent state for movement states[Idle,Run,Air]

const FLOOR_NORMAL = Vector2.UP
export var gravity := 20
export var max_fall_speed := 400
export var max_speed := 300
export var time_for_max_speed := 0.3
export var jump_height := -400

var snap_vector := Vector2(0, 32)
var velocity := Vector2.ZERO
######## Interface Methods #######


func unhandled_input(event: InputEvent) -> void:
	flip_sprite(event)
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		_state_machine.transition_to(states.air,{jumped = jump_height})


func physics_process(delta: float) -> void:
	velocity = horizontal_movement(delta, velocity, max_speed, get_move_direction(), time_for_max_speed)
	print(velocity)
	update_gravity(delta)
	velocity = owner.move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL)
	pass


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


######### Main Actions #########


func horizontal_movement(
	delta: float, old_velocity: Vector2, speed: float, direction: float, speed_time: float
):
	var new_velocity := old_velocity

	if direction != 0:
		new_velocity.x += (speed / speed_time) * direction * delta
		new_velocity.x = clamp(new_velocity.x, -max_speed, max_speed)
	else:
		new_velocity.x = 0
	return new_velocity


func update_gravity(delta:float) -> void:
	var new_velocity := velocity
	new_velocity.y += gravity 
	velocity.y = min(new_velocity.y, max_fall_speed)

########## Utilities #############


func flip_sprite(event: InputEvent) -> void:
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		owner.get_node("Sprite").flip_h = false if get_move_direction() > 0 else true


func get_move_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
