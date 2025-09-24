extends Node2D
class_name Level

@export var data: LevelData


func _ready() -> void:
	Singletons.level = self
