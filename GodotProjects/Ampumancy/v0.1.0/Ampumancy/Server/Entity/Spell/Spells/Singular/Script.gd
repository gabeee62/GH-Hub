extends Spell
class_name SingularSpell

@export var AutoCast: bool
@export var CastDelay: float


func custom_spell_ready() -> void:
	custom_singular_ready()
	
	$Timers/CastDelay.wait_time = CastDelay
	$Timers/CastDelay.start()


func custom_singular_ready() -> void:
	pass


func custom_spell_process(delta: float) -> void:
	custom_singular_process(delta)


func custom_singular_process(delta: float) -> void:
	pass


func delete() -> void:
	if $Timers/CastDelay.time_left > 0:
		disable()
	else:
		unbusy()
		queue_free()


func disable() -> void:
	custom_disable()
	DeleteQueued = true


func custom_disable() -> void:
	pass


func _on_cast_delay_timeout() -> void:
	unbusy()
	if AutoCast and Input.is_action_pressed(CastWith):
		Globals.CurrentPlayer.cast_spell(CastWith)
	if DeleteQueued:
		queue_free()
