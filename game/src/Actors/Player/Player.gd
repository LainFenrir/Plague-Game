extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var ray_plataform := $RayPlataform


export var gravity := 20.0
export var max_fall_speed := 400
export var max_speed := 250
export var jump_force := -400
export var air_move = true
export var climb_speed := 150
export var jump_horizontal_speed :=150

var velocity := Vector2.ZERO


######## Built-in Functions ##########
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	#print(state_machine.state.name)
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass


func _process(delta: float) -> void:
	pass

########### Functions ###########

