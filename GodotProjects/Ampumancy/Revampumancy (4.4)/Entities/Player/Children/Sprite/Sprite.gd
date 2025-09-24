@tool
extends CanvasGroup


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process(delta)


func tool_process(delta: float) -> void:
	pass


func game_process(delta: float) -> void:
	pass


func flip_sprite() -> void:
	$RArms.flip_arms()
	$LArms.flip_arms()
