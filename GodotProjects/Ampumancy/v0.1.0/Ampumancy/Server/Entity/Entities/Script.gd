extends CharacterBody2D
class_name Entity

@export var data: EntityData

@export var OnScreen: bool = false


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	custom_entity_tool_process()


func game_process(delta: float) -> void:
	OnScreen = true if $VisibleOnScreenNotifier2D.is_on_screen() else false
	custom_entity_game_process(delta)


func custom_entity_tool_process() -> void:
	pass


func custom_entity_game_process(delta: float) -> void:
	pass


func damage(damage: int) -> void:
	pass
