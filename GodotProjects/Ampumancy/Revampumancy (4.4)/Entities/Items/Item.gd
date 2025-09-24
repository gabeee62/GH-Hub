extends Area2D
class_name Item

@export var data: ItemData


func _ready() -> void:
	$Sprite.texture = data.texture
