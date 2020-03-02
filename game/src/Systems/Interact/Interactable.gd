extends Area2D
class_name Interactable

export var is_active :=true
onready var actions := $Actions.get_children()
var calls :int =0

func _ready():
	Signals.connect("interaction_start",self,"call_interaction")
	if actions.size() >1:
		actions.sort_custom(self,"action_order_sort")


func call_interaction():
	for i in range(actions.size()):
		if actions[i].is_active:
			actions[i].interact()
	Signals.emit_signal("interaction_finished")


func _on_body_entered(body: Player):
	if is_active:
		Signals.emit_signal("can_interact", true)


func _on_body_exited(body: Player):
	if is_active:
		Signals.emit_signal("can_interact", false)

func action_order_sort(a,b):
	if a.order < b.order:
		return true
	return false
