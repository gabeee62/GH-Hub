extends Node


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process(delta)


func game_process(delta: float) -> void:
	pass


func tool_process(delta: float) -> void:
	pass
