extends Node

signal too_lawful
signal no_lawful
signal lawful_changed
signal inventory_changed
signal game_paused
signal game_unpaused

var lawful := 100
var items: Array[ItemData] = []
var selected_item: ItemData = null

func change_lawful(amount : int):
	lawful += amount
	if amount >= 200:
		set_lawful(200)
		too_lawful.emit()
		lawful_changed.emit()
	
	if amount <= 0:
		set_lawful(0)
		no_lawful.emit()
		lawful_changed.emit()
	
	lawful_changed.emit()

func set_lawful(amount : int):
	lawful = amount

func add_item(item: ItemData) -> bool:
	if items.size() < 3:
		items.append(item)
		inventory_changed.emit()
		return true
	else:
		return false

func remove_item(item: ItemData):
	items.erase(item)
	inventory_changed.emit()

func has_item(item: ItemData) -> bool:
	return item in items

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		selected_item = null
		CursorManager.reset_cursor()
