extends State
class_name PlayerState

var states := {run = "Move/Run", air = "Move/Air", idle = "Move/Idle"}


func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State
