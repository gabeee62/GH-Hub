extends Node

var fireball: PackedScene = preload("res://scenes/spells/fireball.tscn")
var ice_field: PackedScene = preload("res://scenes/spells/ice_field_1.tscn")
var boulder: PackedScene = preload("res://scenes/spells/golemstone_boulder.tscn")


func cast_spell(spell: Utility.SPELLS) -> Array:
	match spell:
		Utility.SPELLS.NONE:
			SignalBus.no_spell.emit()
			return [null, 0]
		Utility.SPELLS.FIREBALL:
			return [fireball, 3]
		Utility.SPELLS.ICE1:
			return [ice_field, 2]
		Utility.SPELLS.BOULDER:
			return [boulder, 2]
	return [null, 0]
