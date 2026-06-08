extends Spell
class_name ChargeSpell

@export var CanBeHeld: bool
@export var CanCastUnfinished: bool # Allows the player to cast this spell before it is fully charged if enabled
@export var ChargeStages: Array[float] # The specific moments during the charge phase that the spell gains a stage (only useful if cast_unfinished is enabled).
@export var ChargeTime: float # How long (secs) it takes for the player to fully charge the spell
@export var CHRNotBusy: float
@export var HoldTime: float
var Charged: bool = false
var CurrentStage: int


func charge_process() -> void:
	if Input.is_action_pressed(CastWith) and CanCastUnfinished:
		for moment: float in ChargeStages:
			if $ChargeDelay.wait_time - $ChargeDelay.time_left >= moment:
				CurrentStage = ChargeStages.find(moment) + 1
				Charged = true
	if not Input.is_action_pressed(CastWith):
		if Charged:
			pass # FIXME: Make a charge cast function


func cast() -> void:
	pass


func _on_charge_time_timeout() -> void:
	Charged = true
	if CanBeHeld and Input.is_action_pressed(CastWith):
		$ChargeHold.start()
	else:
		cast()


func _on_hold_time_timeout() -> void:
	pass
