extends ColorRect

onready var animplayer := $AnimationPlayer


func _ready():
	Signals.connect("play_animation", self, "play_animation")
	pass


func _process(delta):
	pass


func play_animation(animation_name):
	animplayer.play(animation_name)


func _on_animation_finished(anim_name):
	Signals.emit_signal("animation_finished", anim_name)
