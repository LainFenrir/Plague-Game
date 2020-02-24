extends KinematicBody2D

var player_speed := Vector2(200.0, 650.0)
var gravity := 3000.0
const FLOOR_NORMAL := Vector2.UP
var _velocity := Vector2.ZERO


func _ready():
	pass  


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	var direction := get_direction()
	_velocity = calculate_velocity(_velocity, direction, player_speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	var horizontal := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical: float = 0.0
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		vertical = -Input.get_action_strength("ui_accept")
	return Vector2(horizontal, vertical)


func calculate_velocity(velocity: Vector2, direction: Vector2, speed: Vector2) -> Vector2:
	var final_velocity := velocity
	final_velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		final_velocity.y = speed.y * direction.y
	return final_velocity
