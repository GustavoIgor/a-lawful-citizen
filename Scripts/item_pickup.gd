extends Area2D
@export var item_data: ItemData
@export var can_return_item: bool = true

var is_taken := false

func _ready():
	$Sprite2D.texture = item_data.icon

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not is_taken:
			var added = Global.inventory.add_item(item_data)
			if added:
				is_taken = true
				hide()
		else:
			if can_return_item and Global.inventory.has_item(item_data):
				Global.inventory.remove_item(item_data)
				is_taken = false
				show()
