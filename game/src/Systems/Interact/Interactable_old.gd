extends Area2D
#class_name Interactable

export var is_active := true
export var has_trigger := false
onready var actions_children := $Actions.get_children()

var calls: int = 0
var trigger_list = []
var actions = []

# How long until I notice I have to refactor this?
# first notice

func _ready():
	Signals.connect("interaction_start", self, "call_interaction")
	
	actions = actions_children
	self.create_trigger_list()

	if actions.size() > 1:
		if has_trigger:
			trigger_list.sort_custom(self, "action_order_sort")

		actions.sort_custom(self, "action_order_sort")


func call_interaction(object_name,is_trigger = false)->void:
	if object_name == self.name:
		if is_trigger:
			for i in range(trigger_list.size()):
				if trigger_list[i].is_active and not trigger_list[i].has_executed:
					trigger_list[i].interact()
					trigger_list[i].has_executed = true
		else:
			for i in range(actions.size()):
				if actions[i].is_active and not actions[i].has_executed:
					actions[i].interact()
					actions[i].has_executed = true
		Signals.emit_signal("interaction_finished")


func body_entered():
	if is_active:
		if has_trigger:
			self.call_interaction(self.name,true)
		else:
			Signals.emit_signal("can_interact", true, self.name)
		


func body_exited():
	if is_active:
		Signals.emit_signal("can_interact", false, self.name)
	if has_trigger:
		for i in range(trigger_list.size()):
			if trigger_list[i].reset_action:
				trigger_list[i].has_executed = false
	else:
		for i in range(actions.size()):
			if actions[i].reset_action:
				actions[i].has_executed = false


func action_order_sort(a, b):
	if a.order < b.order:
		return true
	return false

func create_trigger_list():
	if has_trigger:
		for i in range(actions.size()):
			if actions[i].is_active and actions[i].on_touch:
				trigger_list.append(actions[i])
				actions.remove(i)
		

