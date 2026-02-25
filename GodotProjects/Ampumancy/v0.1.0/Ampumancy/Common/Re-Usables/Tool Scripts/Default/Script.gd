@tool
extends Node


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	pass


func game_process(_delta: float) -> void:
	pass
