extends RigidBody2D


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = get_parent().velocity
