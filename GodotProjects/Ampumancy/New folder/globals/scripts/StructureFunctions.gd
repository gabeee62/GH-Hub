extends Node


func none() -> void:
	pass


func save_game() -> void:
	SaveHandler.save_to_disk()


func entered_camp() -> void:
	pass


func campfire_heal() -> void:
	Globals.PLAYER.heal(10)
