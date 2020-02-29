extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine


######## Built-in Functions ##########
func _ready()->void:
	pass

func _physics_process(delta:float)-> void:
	print(state_machine.state.name)
	print(position)



func _unhandled_input(event: InputEvent)-> void:
	pass

func _process(delta:float)-> void:
	pass

########### Functions ###########

