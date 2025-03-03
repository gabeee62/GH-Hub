extends Spell

var mouse: Vector2

var direct_impact_damage: int = 50

var particles: ParticleProcessMaterial


func _ready() -> void:
	mouse = (get_global_mouse_position() - $Area2D.global_position).normalized()
	particles = $Area2D/TrailParticles.process_material
	particles.direction = Vector3(-mouse.x, -mouse.y, 0)
	if mouse.x < 0:
		$Area2D/AnimationPlayer.play("fireball_spin_left")
	else:
		$Area2D/AnimationPlayer.play("fireball_spin_right")
	


func _process(delta: float) -> void:
	$Area2D.global_position += mouse * 500 * delta


func explode() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if "team" in body and body.team != team:
		if "damage" in body:
			body.damage(direct_impact_damage)
		explode()
	elif "team" not in body:
		explode()
