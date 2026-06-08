extends Node

@onready var Parent: Character = $".."


func _process(_delta: float) -> void:
	Parent.InputVector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("JUMP"):
		pass
	if event.is_action_pressed("DODGE"):
		pass
