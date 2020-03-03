extends Action

export var next_scene: String

var levels = {"test1": "res://src/Test/TestRoom.tscn", "test2": "res://src/Test/TestRoom2.tscn"}


func interact():
	teleport()
	Signals.emit_signal("interaction_finished")


func teleport():
	var level_path := get_level_path(next_scene)
	get_tree().change_scene(level_path)


func get_level_path(level_name: String) -> String:
	return levels.get(level_name)
