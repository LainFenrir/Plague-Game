extends Interactable 

export var item : Resource

onready var _sprite = $'Sprite'
onready var _collision = $'Collision'

### Egine Functions ###
func _ready() -> void:
	_sprite.texture = item.image
	pass

#### Signals ####
func _on_body_entered(body: Player) -> void:
	body_entered() 
	pass


func _on_body_exited(body: Player) -> void:
	body_exited()
	pass

#### Interact #####
func interact():
	self.pickup()
	
	if not reset_action:
		self.call_deferred("disable")
	pass

func pickup():
	Inventory.pickup_item(item)
	pass
	
func disable():
	_sprite.visible = false
	_collision.disabled = true
	is_active= false
	queue_free()
	pass

func reset_interaction():
	if reset_action:
		has_executed = false
	pass
