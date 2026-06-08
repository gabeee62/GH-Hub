extends Node2D
class_name Spell

var Origin: Marker2D
var CastWith: StringName

@export var PrimaryElement: SpellLibrary.Elements
@export var SecondaryElement: SpellLibrary.Elements # Secondary element can be left blank

enum CastType {SINGULAR, CONTINUOUS, CHARGE, EFFECT}

var Caster: Entity
var DeleteQueued: bool

@export_group("Cast Settings")
@export var ManaCost: int
@export var MysticCost: int
@export var SolarCost: int
@export var FollowsCaster: bool
@export var Type: CastType
@export_group("", "")


func _ready() -> void:
	custom_spell_ready()
	
	busy()
	top_level = not FollowsCaster


func custom_spell_ready() -> void:
	pass


func _process(delta: float) -> void:
	custom_spell_process(delta)


func custom_spell_process(delta: float) -> void:
	pass


func busy() -> void:
	match CastWith:
		"PLAYER_CAST_LEFT":
			Globals.CurrentPlayer.Data.Equipment.LeftBusy = true
		"PLAYER_CAST_RIGHT":
			Globals.CurrentPlayer.Data.Equipment.RightBusy = true


func unbusy() -> void:
	match CastWith:
		"PLAYER_CAST_LEFT":
			Globals.CurrentPlayer.Data.Equipment.LeftBusy = false
		"PLAYER_CAST_RIGHT":
			Globals.CurrentPlayer.Data.Equipment.RightBusy = false
