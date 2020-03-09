extends Action

export var next_scene: String
export var teleport_to: String


func interact():
	teleport()
	Signals.emit_signal("interaction_finished")


func teleport():
	Globals.transport_to(next_scene, teleport_to)
