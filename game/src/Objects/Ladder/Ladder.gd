extends Node2D

onready var pos_node = get_node("../Position2D")


func _ready() -> void:
	pass


func _on_body_entered(body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb",true,pos)
	pass # Replace with function body.


func _on_body_exited(body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb",false,pos)
	pass # Replace with function body.


func _on_DropArea_body_entered(body: Node) -> void:
	Signals.emit_signal("will_drop",true)
	pass # Replace with function body.


func _on_DropArea_body_exited(body: Node) -> void:
	Signals.emit_signal("will_drop",false)
	pass # Replace with function body.
