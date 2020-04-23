extends Area2D
class_name Interactable

export var is_active := true
export var has_trigger := false
export var reset_action := true

var has_executed := false


func _ready():
	Signals.connect(Signals.INTERACTION_START, self, "call_interaction")



func call_interaction(object_name,is_trigger = false)->void:
	if object_name == self.name:
		if is_active and not has_executed:
			interact()
			has_executed = true
		Signals.emit_signal(Signals.INTERACTION_FINISHED)


###### Signal Handlers #####
func body_entered():
	if is_active:
		if has_trigger:
			self.call_interaction(self.name,true)
		else:
			Signals.emit_signal(Signals.CAN_INTERACT, true, self.name)
		


func body_exited():
	if is_active:
		Signals.emit_signal(Signals.CAN_INTERACT, false, self.name)
	if reset_action:
		has_executed = false

##### Virtual Methods ####
func interact():
	pass
