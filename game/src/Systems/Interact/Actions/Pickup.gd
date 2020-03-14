extends Action

#TODO:MOVE THIS TO ROOT NODE
export var item : Resource

func _ready():
	pass

func interact():
	pickup()

func pickup():
	Globals.pickup_item(item)
	get_node("../../Sprite").visible = false
	
