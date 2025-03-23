extends Spell

# FIX PARTICLES

signal stop_emitting()


func _process(delta: float) -> void:
	$Spell.position.y += 800 * delta


func _on_body_entered(body: Node2D) -> void:
	if "team" not in body or "team" in body and body.team != team:
		var spell: Spell = next_phase_scene.instantiate()
		spell.position = $Spell.position
		spell.team = team
		SignalBus.spell_cast.emit(spell)
		SignalBus.reparent_spell_particles.emit($Spell/GPUParticles2D)
		stop_emitting.emit()
		queue_free()
