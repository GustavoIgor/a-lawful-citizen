extends Node

var default_cursor = null

func _ready():
	default_cursor = null

func set_cursor(icon: Texture2D):
	Input.set_custom_mouse_cursor(icon)

func reset_cursor():
	Input.set_custom_mouse_cursor(default_cursor)
