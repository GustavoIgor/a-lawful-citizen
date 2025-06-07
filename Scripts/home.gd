extends Node2D

func _ready() -> void:
	DialogueManager.start_dialogue(DialogueDataBase.exemplo)
