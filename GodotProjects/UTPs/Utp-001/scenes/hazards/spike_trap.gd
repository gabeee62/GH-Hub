extends Area2D

var extended: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimationPlayer.play("stab")
