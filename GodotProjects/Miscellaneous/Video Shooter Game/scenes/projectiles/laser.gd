extends Area2D

var velocity: int = 2400

var direction: Vector2


func _ready() -> void:
	look_at(get_global_mouse_position())
	direction = get_global_mouse_position() - position


func _process(delta: float) -> void:
	position += direction.normalized() * velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if "damage" in body:
		body.damage()
	queue_free()


func _on_life_timer_timeout() -> void:
	queue_free()
