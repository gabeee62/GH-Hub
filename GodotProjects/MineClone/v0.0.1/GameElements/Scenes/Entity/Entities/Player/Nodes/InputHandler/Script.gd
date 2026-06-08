extends Node

@onready var Parent: Player = $".."


func _process(_delta: float) -> void:
	Parent.WASDVector = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_BACKWARD", "MOVE_FORWARD")
