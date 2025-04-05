extends CharacterBody2D
class_name Entity

@export var DATA: EntityData


func on_hit(damage: int) -> void:
	pass


func hit(damage: int) -> void:
	on_hit(damage)
	if DATA.HEALTH > 0:
		pass
	elif DATA.HEALTH < 0:
		pass
