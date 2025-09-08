extends Area2D

var direction: Vector2
@export var movespeed: int


func _ready() -> void:
	direction = get_local_mouse_position().normalized()
	if direction.x < 0:
		$AnimationPlayer.play_backwards("spin")
	elif direction.x > 0:
		$AnimationPlayer.play("spin")


func _process(delta: float) -> void:
	position += direction * movespeed * delta
