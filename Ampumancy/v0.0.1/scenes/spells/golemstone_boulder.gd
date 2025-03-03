extends Spell

var velocity: int = 500


func _ready() -> void:
	var mouse: Vector2 = get_global_mouse_position()
	$Boulder.linear_velocity = mouse.normalized() * velocity
	$Boulder.angular_velocity = deg_to_rad(randi_range(-360, 360))
