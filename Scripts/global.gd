extends Node

signal too_lawful
signal no_lawful
signal lawful_changed

var lawful := 100

func change_lawful(amount : int):
	lawful += amount
	if amount >= 200:
		set_lawful(200)
		too_lawful.emit()
		lawful_changed.emit()
	
	if amount <= 0:
		set_lawful(0)
		no_lawful.emit()
		lawful_changed.emit()
	
	lawful_changed.emit()

func set_lawful(amount : int):
	lawful = amount
