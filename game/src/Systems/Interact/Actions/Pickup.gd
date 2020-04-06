extends Action

onready var _parent = $'../..'
onready var _sprite = $'../../Sprite'
onready var _collision = $'../../Collision'

func _ready():
	pass

func interact():
	self.pickup()
	
	if not reset_action:
		self.call_deferred("disable")
	

func pickup():
	var item = _parent.item 
	Inventory.pickup_item(item)
	
	
func disable():
	_sprite.visible = false
	_parent.is_active= false
	_collision.disabled = true
	_parent.queue_free()
