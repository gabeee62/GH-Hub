extends Node2D
class_name Spell

var origin: StringName

enum CastType {SINGULAR, CONTINUOUS, CHARGE}

@export_group("Cast Settings")
@export var mana_cost: int # Mana deducted from player's mana pool when this spell is cast
@export var cast_type: CastType
@export_subgroup("Singular")
@export var auto_cast: bool # Allows the player to hold to continuously re-cast this spell if enabled
@export var delay: float # The amount of time that must pass for the player to be able to cast this spell again
@export_subgroup("Continuous")
@export var finish_cycle: bool # Allows the spell to complete its animation cycle before dissipating if the player releases their mouse early
@export_subgroup("Charge")
@export var charge_rate: float # 0 - 100 scale that determines how long this spell must charge to fully cast
@export var cast_unfinished: bool # Allows the player to cast this spell before it is fully charged if enabled
@export_group("", "")


func _process(_delta: float) -> void:
	match cast_type:
		CastType.SINGULAR:
			pass
		CastType.CONTINUOUS:
			if not Input.is_action_pressed(origin):
				if finish_cycle:
					pass
				else:
					queue_free() # Change to a delete animation for cleaner spell dissipation
		CastType.CHARGE:
			pass
