extends CharacterBody2D

@onready var animation = $AnimationPlayer

var game_paused = false

var speed = 70

func _ready() -> void:
	Global.game_paused.connect(_on_game_paused)
	Global.game_unpaused.connect(_on_game_unpaused)

func _process(delta: float) -> void:
	if game_paused:
		return
	var direction := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")
	if Input.is_action_pressed("sprint"):
		speed = 150
	else:
		speed = 100
		
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

func _on_game_paused():
	game_paused = true
	
func _on_game_unpaused():
	game_paused = false
