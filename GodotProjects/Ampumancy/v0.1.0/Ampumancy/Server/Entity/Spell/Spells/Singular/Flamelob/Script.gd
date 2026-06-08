extends SingularSpell
class_name Flamelob

@onready var TrailParticles: ParticleProcessMaterial = preload("res://Server/Entity/Spell/Spells/Singular/Flamelob/Particles/Trail.tres")
@onready var ExplosionParticles: ParticleProcessMaterial = preload("res://Server/Entity/Spell/Spells/Singular/Flamelob/Particles/Explosion.tres")

@export var FireballDamage: int
@export var ExplosionDamage: int

@export var Speed: float
var Angle: Vector2 = Vector2.ZERO


func custom_singular_ready() -> void:
	$Sprite.look_at(get_global_mouse_position())


func custom_singular_process(delta: float) -> void:
	if Angle == Vector2.ZERO and Origin:
		global_position = Origin.global_position
		Angle = (get_global_mouse_position() - global_position).normalized()
		#if Angle.x >= 0:
		#	$AnimationPlayer.play("FireballSpinRight")
		#else:
		#	$AnimationPlayer.play("FireballSpinLeft")
		$GPUParticles2D.process_material = TrailParticles
		$GPUParticles2D.emitting = true
	
	global_position += Speed * Angle * delta


func explode() -> void:
	$GPUParticles2D.process_material = ExplosionParticles
	$AnimationPlayer.play("Explode")


func _on_fireball_hitbox_body_entered(body: Node2D) -> void:
	if body != Caster:
		if body.is_class("Entity"):
			body.damage()
		explode()
