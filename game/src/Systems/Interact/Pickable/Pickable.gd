extends Interactable 



func _on_body_entered(body: Player) -> void:
	body_entered() 


func _on_body_exited(body: Player) -> void:
	body_exited()
