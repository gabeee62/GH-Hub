extends Node

var spell_lib: Dictionary = {
	0: null,
	1: preload("res://scenes/spells/fireball/fireball.tscn"),
	2: preload("res://scenes/spells/ice_field/ice_field.tscn")}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func cast_spell(id: int) -> PackedScene:
	return spell_lib[id]
