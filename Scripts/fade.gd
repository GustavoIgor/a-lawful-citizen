extends CanvasLayer

@onready var animation := $AnimationPlayer

func fade_transition(path : String):
	show()
	animation.play("fade_in")
	await animation.animation_finished
	get_tree().change_scene_to_file(path)
	animation.play("fade_out")
	await animation.animation_finished
	hide()
