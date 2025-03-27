extends RigidBody2D

var direction: Vector2


func _ready() -> void:
	direction = get_global_mouse_position() - position
	linear_velocity = direction.normalized() * 750
	angular_velocity = deg_to_rad(randi_range(45, 345))


func explode():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
