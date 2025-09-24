extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("HIDEUI"):
		visible = not visible
		match Input.mouse_mode:
			Input.MOUSE_MODE_HIDDEN:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
