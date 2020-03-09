extends Action

export var item : Resource

func _ready():
	pass

func interact():
	pickup()

func pickup():
	Globals.pickup_item(item)
	
