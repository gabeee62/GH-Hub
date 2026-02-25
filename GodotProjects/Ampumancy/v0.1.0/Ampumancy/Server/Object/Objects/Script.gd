@tool
extends Node2D
class_name GameObject

@export var TilePosition: Vector2i


func _ready() -> void:
	global_position = TilePosition * 32


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	pass


func game_process(_delta: float) -> void:
	pass
