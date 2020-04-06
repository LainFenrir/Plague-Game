extends Node

var player_inventory := []

func _ready() -> void:
	pass

##### Inventory System ######

func pickup_item(item: Resource):
	var path :=item.resource_path
	if not player_inventory.empty():
		var worked = try_increase_quantity(path)
		if not worked:
			set_new_item(path)
	else:
		set_new_item(path)
	print(player_inventory)


func set_new_item(path: String):
	var dic = {"path":path, "quantity": 1}
	player_inventory.append(dic)


func try_increase_quantity(path: String):
	for i in range(player_inventory.size()):
			if player_inventory[i].path == path:
				player_inventory[i].quantity += 1
				return true
	return false