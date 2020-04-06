extends Interactable

export var next_scene: String
export var teleport_to: String
export var is_local := false

func _on_body_entered(body: Player) -> void:
	body_entered() 


func _on_body_exited(body: Player) -> void:
	body_exited()
