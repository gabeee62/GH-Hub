extends Spell
class_name ContinuousSpell

@export var CycleTime: float
@export var FinishCycle: bool # Allows the spell to complete its animation cycle before dissipating if the player releases their mouse early
@export var NotBusy: float
@export var NoCycle: bool


func custom_spell_ready() -> void:
	custom_continuous_ready()
	
	$Timers/CycleTime.wait_time = CycleTime
	$Timers/NotBusyCD.wait_time = NotBusy
	
	cast()


func custom_continuous_ready() -> void:
	pass


func custom_spell_process(delta: float) -> void:
	custom_continuous_process(delta)
	if not Input.is_action_pressed(CastWith):
		delete()


func custom_continuous_process(delta: float) -> void:
	pass


func cast() -> void:
	$Timers/CycleTime.start()


func delete() -> void:
	if FinishCycle:
		DeleteQueued = true
	else:
		disable()


func disable() -> void:
	custom_disable()
	$Timers/NotBusyCD.start()


func custom_disable() -> void:
	pass


func _on_cycle_time_timeout() -> void:
	if DeleteQueued:
		disable()
	else:
		if Input.is_action_pressed(CastWith) and Globals.CurrentPlayer.has_enough_mana([SolarCost, MysticCost, ManaCost]):
			cast()
		else:
			disable()


func _on_not_busy_cd_timeout() -> void:
	unbusy()
	queue_free()
