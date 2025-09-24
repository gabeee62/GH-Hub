extends Node2D
class_name Spell

enum CastType {INSTANT_CAST, PERSISTENT_CAST, CHARGE_AND_RELEASE}
enum SpellType {PROJECTILE, AREA_OF_EFFECT, PLAYER_EFFECT, ENEMY_EFFECT}

@export var cast_type: CastType
@export var spell_type: SpellType


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	match cast_type:
		CastType.INSTANT_CAST:
			pass
		CastType.PERSISTENT_CAST:
			pass
		CastType.CHARGE_AND_RELEASE:
			pass
