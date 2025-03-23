extends Resource
class_name PlayerData

@export var health: int


func change_health(value: int):
	health += value
