extends State
class_name PlayerState

var states := {
	run = "Move/Run", 
	air = "Move/Air", 
	idle = "Move/Idle", 
	interact = "Interact", 
	die = "Die", 
	attack = "Attack"
}

var is_interactable := false


func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State
	Signals.connect("can_interact", self, "set_is_interactable")


func set_is_interactable(value: bool):
	is_interactable = value


func get_move_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
