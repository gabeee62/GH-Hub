extends Area2D

@onready var TRUE_PARENT: Spell = get_parent().get_parent()
var VECTOR: Vector2


func _process(delta: float) -> void:
	global_position += VECTOR * TRUE_PARENT.MOVESPEED * delta


func explode() -> void:
	TRUE_PARENT.MOVESPEED = 0.0
	$AnimationTree.active = false
	$AnimationPlayer.play("explode")
	$ParticleHandlers/TrailParticles.emitting = false
	$ParticleHandlers/ExplodeParticles.emitting = true


func _on_death_timer_timeout() -> void:
	explode()


func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(TRUE_PARENT.DAMAGE)
	if body is not Player:
		explode()


func _on_explode_hitbox_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(TRUE_PARENT.EXPLODE_DAMAGE)
