extends Sprite2D
@onready var animation := $AnimationPlayer

func _ready() -> void:
	check_animation()
	
func check_animation():
	if Global.lawful > 150:
		animation.play('aware')
	elif Global.lawful > 50:
		animation.play("normal")
	else:
		animation.play("suspicious")
