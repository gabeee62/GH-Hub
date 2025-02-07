extends Area2D

var direction: int


func _process(delta: float) -> void:
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	position.x += 500 * direction * delta


func _on_life_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if "damage" in body:
		body.damage()
	queue_free()
