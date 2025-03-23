extends GPUParticles2D


func _ready() -> void:
	emitting = true


func _on_finished() -> void:
	SignalBus.kill_spell_particles.emit(self)


func _on_ice_field_1_stop_emitting() -> void:
	emitting = false
