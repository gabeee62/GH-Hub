extends Area2D

@export var MOVESPEED: float
var VECTOR: Vector2


func _process(delta: float) -> void:
	global_position += VECTOR * MOVESPEED * delta
	$Hitboxes/FireballHitBox.KBVECTOR.x = $Hitboxes/FireballHitBox.KBVECTOR.abs().x * (VECTOR.abs().x / VECTOR.x)


func explode() -> void:
	MOVESPEED = 0.0
	$AnimationHandlers/AnimationTree.active = false
	$AnimationHandlers/AnimationPlayer.play("explode")
	$ParticleHandlers/TrailParticles.emitting = false
	$ParticleHandlers/ExplodeParticles.emitting = true


func _on_death_timer_timeout() -> void:
	explode()


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		explode()
