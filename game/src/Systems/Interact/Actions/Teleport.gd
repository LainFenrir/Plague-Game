extends Action

onready var _parent = $'../..'

var next_scene: String
var teleport_to: String
var is_local: bool


func _ready() -> void:
	yield(_parent, "ready")
	self.next_scene = _parent.next_scene
	self.teleport_to = _parent.teleport_to
	self.is_local = _parent.is_local


func interact() -> void:
	play_transition("fade_in")
	yield(Interface.transition_animation.anim_player,"animation_finished")
	teleport()
	play_transition("fade_out")
	#Signals.emit_signal("interaction_finished")


func teleport() -> void:
	if self.is_local:
		local_teleport()
	else:
		Transporter.transport_to(next_scene, teleport_to)


func local_teleport() -> void:
	Transporter.set_player_pos(teleport_to)
	pass

func play_transition(animation_name):
	Interface.transition_animation.play_animation(animation_name)
	pass
