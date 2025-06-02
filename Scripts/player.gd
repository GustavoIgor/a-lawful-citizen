extends CharacterBody2D

@onready var animation = $AnimationPlayer

var game_paused = false

var speed = 100

func _process(delta: float) -> void:
	if game_paused:
		return
	var direction := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	animate_player(direction)

func animate_player(direction : Vector2):
	if direction.y > 0:
		animation.play("walk_down")
	elif direction.y < 0:
		animation.play("walk_up")
	elif direction.x > 0:
		animation.play("walk_right")
	elif direction.x < 0:
		animation.play("walk_left")
			
	if direction == Vector2(0,0):
		animation.stop()
