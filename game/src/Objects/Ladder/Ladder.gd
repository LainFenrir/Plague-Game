tool
extends Node2D

onready var collision_area = $'Area/CollisionShape2D'
onready var drop_area = $'DropArea'
onready var pos_node = $'Position2D'
onready var plataform = $'Plataform'
onready var platform_collision = $'Plataform/CollisionShape2D'

enum PlatformType { NO_PLATFORM, HAS_PLATFORM }
export (PlatformType) var platform_type = PlatformType.HAS_PLATFORM setget set_plataform_type

enum LadderSize { _6_TILES = 6, _8_TILES = 8, _11_TILES = 11, _16_TILES = 16, _24_TILES = 24 }

export (LadderSize) var ladder_size = LadderSize._6_TILES setget set_lader_size
var ladders_sizes := {
	6:{
		"collisionPath": "res://assets/CollisionShapes/Ladders/ladder6_tiles.tres",
		"dropAreaPosition": Vector2(0, 87),
		"collisionPosition": Vector2(0, 41)
	},
	8:{
		"collisionPath": "res://assets/CollisionShapes/Ladders/ladder8_tiles.tres",
		"dropAreaPosition": Vector2(0, 124),
		"collisionPosition": Vector2(0, 59)
	},
	11:{
		"collisionPath": "res://assets/CollisionShapes/Ladders/ladder11_tiles.tres",
		"dropAreaPosition": Vector2(0, 169),
		"collisionPosition": Vector2(0, 82)
	},
	16:{
		"collisionPath": "res://assets/CollisionShapes/Ladders/ladder16_tiles.tres",
		"dropAreaPosition": Vector2(0, 246),
		"collisionPosition": Vector2(0, 120)
	},
	24:{
		"collisionPath": "res://assets/CollisionShapes/Ladders/ladder24_tiles.tres",
		"dropAreaPosition": Vector2(0, 375),
		"collisionPosition": Vector2(0, 184)
	}
}


func _ready() -> void:
	set_plataform_type(platform_type)
	set_lader_size(ladder_size)
	pass


func _process(delta: float) -> void:
	pass


func set_lader_size(value: int) -> void:
	ladder_size = value

	var ladder_resource = ladders_sizes.get(value)
	var collision_path = ladder_resource.get("collisionPath")
	var ladder_position = ladder_resource.get("collisionPosition")
	var ladder_drop_position = ladder_resource.get("dropAreaPosition")

	if has_node('Area/CollisionShape2D'):
		if collision_path != null and ladder_position != null:
			get_node("Area/CollisionShape2D").shape = load(collision_path)
			get_node("Area/CollisionShape2D").position = ladder_position

	if has_node("DropArea/CollisionShape2D"):
		get_node("DropArea/CollisionShape2D").position = ladder_drop_position


func set_plataform_type(value) -> void:
	platform_type = value
	match platform_type:
		PlatformType.NO_PLATFORM:
			if has_node("Platform/CollisionShape2D"):
				get_node("Platform").visible = false
				get_node("Platform/CollisionShape2D").disabled = true
		PlatformType.HAS_PLATFORM:
			if has_node("Platform/CollisionShape2D"):
				get_node("Platform").visible = true
				get_node("Platform/CollisionShape2D").disabled = false


func _on_body_entered(_body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb", true, pos)


func _on_body_exited(_body: Node) -> void:
	var pos = pos_node.global_position
	Signals.emit_signal("can_climb", false, pos)


func _on_DropArea_body_entered(_body: Node) -> void:
	Signals.emit_signal("will_drop", true)


func _on_DropArea_body_exited(_body: Node) -> void:
	Signals.emit_signal("will_drop", false)
