extends Node2D


func flip_arms() -> void:
	move_child(get_child(0), 1)
