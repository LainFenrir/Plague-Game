extends State
class_name PlayerState

var states := {
	run = "Move/Run", 
	air = "Move/Air", 
	idle = "Move/Idle", 
	interact = "interact", 
	die = "die", 
	attack = "attack"
}


func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State
