extends RigidBody2D

@export var DAMAGE: int


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(int(DAMAGE * linear_velocity.abs().x / 400))
