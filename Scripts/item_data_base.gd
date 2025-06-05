extends Node
class_name ItemDatabase

var items: Dictionary = {}

func _ready():
	items = {
		"coffee_mug": load("res://Resources/coffee_mug.tres"),
	}

func get_item(name: String) -> ItemData:
	return items.get(name, null)
