extends Spell
class_name EffectSpell

@export var EffectTime: float


func custom_spell_ready() -> void:
	custom_effect_ready()


func custom_effect_ready() -> void:
	pass


func custom_spell_process(delta: float) -> void:
	custom_effect_process()


func custom_effect_process() -> void:
	pass


func _on_effect_time_timeout() -> void:
	pass # Replace with function body.
