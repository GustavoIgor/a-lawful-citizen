extends VBoxContainer

var items: Array[ItemData] = []
var selected_item: ItemData = null

@onready var slots = [
	$Slot1,
	$Slot2,
	$Slot3
]

func _ready():
	update_slots()

func add_item(item: ItemData) -> bool:
	if items.size() < 3:
		items.append(item)
		update_slots()
		return true
	else:
		return false

func remove_item(item: ItemData):
	items.erase(item)
	update_slots()

func update_slots():
	for i in range(3):
		if i < items.size():
			slots[i].texture_normal = items[i].icon
		else:
			slots[i].texture_normal = null

func on_slot_pressed(index: int):
	if index >= items.size():
		return
	
	var clicked_item = items[index]
	
	if selected_item == null:
		selected_item = clicked_item
		CursorManager.set_cursor(clicked_item.icon)
	elif selected_item == clicked_item:
		selected_item = null
		CursorManager.reset_cursor()
	else:
		attempt_combine(selected_item, clicked_item)

func attempt_combine(item_a: ItemData, item_b: ItemData):
	if item_a.combinable_with.has(item_b.name):
		var result_name = item_a.combinable_with[item_b.name]
		var result_item = preload("res://Scenes/item_data_base.tscn").get_item(result_name)
		if result_item:
			remove_item(item_b)
			add_item(result_item)
			print("Itens combinados:", item_a.name, "+", item_b.name, "->", result_item.name)
	else:
		print("Esses itens não podem ser combinados.")
	
	selected_item = null
	CursorManager.reset_cursor()

func _on_slot_1_pressed() -> void:
	on_slot_pressed(0)

func _on_slot_2_pressed() -> void:
	on_slot_pressed(1)

func _on_slot_3_pressed() -> void:
	on_slot_pressed(2)
