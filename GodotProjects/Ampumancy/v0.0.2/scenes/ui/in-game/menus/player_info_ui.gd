extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("INFO"):
		visible = not visible
