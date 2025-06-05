extends VBoxContainer

@onready var slots = [
	$Slot1,
	$Slot2,
	$Slot3
]

func _ready():
	update_slots()
	Global.inventory_changed.connect(_on_inventory_changed)

func _on_inventory_changed():
	update_slots()

func update_slots():
	for i in range(3):
		if i < Global.items.size():
			slots[i].texture_normal = Global.items[i].icon
		else:
			slots[i].texture_normal = null

func on_slot_pressed(index: int):
	if index >= Global.items.size():
		return
	
	var clicked_item = Global.items[index]
	
	if Global.selected_item == null:
		Global.selected_item = clicked_item
		CursorManager.set_cursor(clicked_item.icon)
	elif Global.selected_item == clicked_item:
		Global.selected_item = null
		CursorManager.reset_cursor()
	else:
		attempt_combine(Global.selected_item, clicked_item)

func attempt_combine(item_a: ItemData, item_b: ItemData):
	if item_a.combinable_with.has(item_b.name):
		var result_name = item_a.combinable_with[item_b.name]
		var result_item = ItemDataBase.get_item(result_name)
		if result_item:
			Global.remove_item(item_b)
			Global.add_item(result_item)
			print("Itens combinados:", item_a.name, "+", item_b.name, "->", result_item.name)
	else:
		print("Esses itens não podem ser combinados.")
	
	Global.selected_item = null
	CursorManager.reset_cursor()

func _on_slot_1_pressed() -> void:
	on_slot_pressed(0)

func _on_slot_2_pressed() -> void:
	on_slot_pressed(1)

func _on_slot_3_pressed() -> void:
	on_slot_pressed(2)
