extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
const FLOOR_NORMAL := Vector2.UP

func _physics_process(delta):
	print(state_machine.state.name)
