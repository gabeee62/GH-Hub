extends Node

var spell_lib: Dictionary = {
	0: null,
	1: preload("res://scenes/spells/flame_hurl/flame_hurl.tscn"),
	2: preload("res://scenes/spells/ice_flurry/ice_flurry.tscn"),
	3: preload("res://scenes/spells/stone_launch/stone_launch.tscn")}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func cast_spell(id: int) -> PackedScene:
	return spell_lib[id]
