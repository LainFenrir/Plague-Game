extends Node2D

onready var pos_node =  $'Position2D'



func _on_body_entered(_body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb", true, pos)


func _on_body_exited(_body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb", false, pos)


func _on_DropArea_body_entered(_body: Node) -> void:
	Signals.emit_signal("will_drop", true)


func _on_DropArea_body_exited(_body: Node) -> void:
	Signals.emit_signal("will_drop", false)
