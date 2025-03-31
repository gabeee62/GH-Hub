extends Entity


func _on_hurtbox_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("hit")
