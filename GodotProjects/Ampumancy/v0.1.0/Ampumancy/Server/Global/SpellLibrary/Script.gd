extends Node

enum Elements {NONE, FIRE, ICE, GROWTH, EARTH, POSITIVE, NEGATIVE, LIGHT, DARK, COSMIC}

@export var SpellArray: Array[PackedScene]


func get_spell(id: int) -> Spell:
	var spell_scene: PackedScene = SpellArray[id]
	var new_spell: Spell = spell_scene.instantiate()
	return new_spell
