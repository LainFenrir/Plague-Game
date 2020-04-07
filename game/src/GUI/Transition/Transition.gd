extends Node

onready var anim_player := $'Shader/AnimPlayer'



func _ready():
	pass


func _process(delta):
	pass


func play_animation(animation_name):
	anim_player.play(animation_name)
