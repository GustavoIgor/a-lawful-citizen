extends CanvasLayer

signal dialogue_ended
signal choice_made(choice_text)

var dialogue_data = []
var current_index = 0
var is_active = false
var is_typing = false
var typing_speed = 0.03

@onready var name_label = $Panel/VBoxContainer/HBoxContainer/Label
@onready var text_label = $Panel/VBoxContainer/HBoxContainer/RichTextLabel
@onready var choices_box = $Panel/VBoxContainer/VBoxContainer

func start_dialogue(data: Array):
	dialogue_data = data
	current_index = 0
	is_active = true
	$Panel.show()
	show_next()

func show_next():
	Global.game_paused.emit()
	choices_box.hide()
	_clear_choices()
	text_label.text = ""
	
	if current_index >= dialogue_data.size():
		end_dialogue()
		return

	var entry = dialogue_data[current_index]

	name_label.text = entry.get("name", "")
	
	var text = entry.get("text", "")
	await type_text(text)

	if entry.has("choices"):
		show_choices(entry["choices"])
	else:
		current_index += 1

func show_choices(choices: Array):
	choices_box.show()
	for choice_text in choices:
		var btn = Button.new()
		btn.text = choice_text
		btn.pressed.connect(_on_choice_pressed.bind(choice_text))
		choices_box.add_child(btn)

func _on_choice_pressed(choice_text):
	choice_made.emit(choice_text)
	current_index += 1
	show_next()

func end_dialogue():
	Global.game_unpaused.emit()
	is_active = false
	$Panel.hide()
	dialogue_ended.emit()

func _unhandled_input(event):
	if is_active and event.is_action_pressed("ui_accept") and not is_typing and choices_box.visible == false:
		show_next()

func _clear_choices():
	for child in choices_box.get_children():
		child.queue_free()

# Texto digitado
func type_text(text: String) -> void:
	is_typing = true
	text_label.text = ""
	for i in text.length():
		text_label.text += text[i]
		await get_tree().create_timer(typing_speed).timeout
	is_typing = false
