extends State
class_name PlayerState

#* Base class for all the player states, a way to center things common to all states


var states := {
	run = "Move/Run", 
	air = "Move/Air", 
	idle = "Move/Idle", 
	interact = "Interact", 
	die = "Die",
	climb = "Move/Climb", 
	attack = "Attack",
	stagger = "Move/Stagger"
}

var is_interactable := false
var can_climb := false
var ladder_position : Vector2
var is_climbing := false
var will_drop :=false
var interactable_object : String

func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State
	Signals.connect(Signals.CAN_INTERACT, self, "set_is_interactable")
	Signals.connect(Signals.CAN_CLIMB, self, "set_can_climb")
	Signals.connect(Signals.WILL_DROP, self, "set_will_drop")


#### Signals ####
func set_is_interactable(value: bool,object_name:String):
	is_interactable = value
	interactable_object = object_name
	print(interactable_object)

	
func set_can_climb(value: bool,pos: Vector2):
	can_climb = value
	ladder_position = pos

	
func set_will_drop(value:bool):
	will_drop = value

### General Functions ###
func get_move_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func get_vertical_direction() -> float:
	return Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
