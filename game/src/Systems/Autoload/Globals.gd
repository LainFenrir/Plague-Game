extends Node

var levels = {
	"TestRoom": "res://src/Test/TestRoom.tscn", 
	"TestRoom2": "res://src/Test/TestRoom2.tscn"
	}

var actual_scene


func _ready() -> void:
	actual_scene = get_tree().get_current_scene()
	pass


func transport_to(scene_name: String, to_object = "") -> void:
	var old_scene = get_tree().current_scene
	var level_path := get_level_path(scene_name)
	var new_scene = ResourceLoader.load(level_path).instance()

	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	# Need to call this everytime a scene is changed
	actual_scene = get_tree().get_current_scene()
	if not to_object.empty():
		set_player_pos(to_object)
	old_scene.queue_free()


func set_player_pos(to_object: String) -> void:
	var object = actual_scene.find_node(to_object)
	var pos = _return_node_by_type(object, Position2D)

	actual_scene.get_node("Player").position = pos.get_global_position()


func _return_node_by_type(parent, type):
	for child in parent.get_children():
		if child is type:
			return child


func get_level_path(level_name: String) -> String:
	return levels.get(level_name)
