extends Interactable 

export var item : Resource

onready var _sprite = $Sprite

func _ready() -> void:
	_sprite.texture = item.image

func _on_body_entered(body: Player) -> void:
	body_entered() 


func _on_body_exited(body: Player) -> void:
	body_exited()
