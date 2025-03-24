extends Node

enum SPELL_IDS {NONE, FRBL, ICFD, BLDR}

var fireball_scene: PackedScene = preload("res://scenes/spells/fireball/fireball.tscn")
var ice_field_scene: PackedScene = preload("res://scenes/spells/ice_field/ice_field.tscn")


func cast_spell(id: SPELL_IDS) -> PackedScene:
	match id:
		SPELL_IDS.FRBL:
			return fireball_scene
		SPELL_IDS.ICFD:
			return ice_field_scene
	return null
