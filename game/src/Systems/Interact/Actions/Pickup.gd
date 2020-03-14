extends Action

onready var _parent = get_node("../../")
onready var _sprite = get_node("../../Sprite")
onready var _collision = get_node("../../Collision")

func _ready():
	pass

func interact():
	self.pickup()
	
	if not reset_action:
		self.disable()
	

func pickup():
	var item = _parent.item 
	Globals.pickup_item(item)
	
	
func disable():
	_sprite.visible = false
	_parent.is_active= false
	_collision.disabled = true
	_parent.queue_free()
