extends Interactable

export var next_scene: String
export var teleport_to: String
export var is_local := false


##### Signals ####
func _on_body_entered(body: Player) -> void:
	print("entered")
	body_entered() 
	pass


func _on_body_exited(body: Player) -> void:
	print("out")
	body_exited()
	pass

##### Interact ######
func interact() -> void:
	play_transition("fade_in")
	yield(Interface.transition_animation.anim_player,"animation_finished")
	teleport()
	play_transition("fade_out")
	pass


func teleport() -> void:
	if is_local:
		local_teleport()
	else:
		Transporter.transport_to(next_scene, teleport_to)
	pass


func local_teleport() -> void:
	Transporter.set_player_pos(teleport_to)
	pass

func play_transition(animation_name):
	Interface.transition_animation.play_animation(animation_name)
	pass
