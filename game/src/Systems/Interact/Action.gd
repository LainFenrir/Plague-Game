extends Node
class_name Action

export var is_active := true
export var on_touch := false
export var order := 0
export var wait_finish := true
export var reset_action := true
var has_executed := false


func _ready():
	pass


func interact():
	pass

func reset_interaction():
	if reset_action:
		has_executed = false
