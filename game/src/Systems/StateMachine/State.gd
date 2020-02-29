extends Node
class_name State
# Base State class used as an interface for the states

onready var _state_machine := _get_state_machine(self)
var _parent: State = null


func _ready() -> void:
	yield(owner, "ready")
	_parent = get_parent() as State


#virtual method
func unhandled_input(event: InputEvent) -> void:
	pass


#virtual method
func physics_process(delta: float) -> void:
	pass


#virtual method
func enter(msg: Dictionary = {}) -> void:
	pass


#virtual method
func exit() -> void:
	pass


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
