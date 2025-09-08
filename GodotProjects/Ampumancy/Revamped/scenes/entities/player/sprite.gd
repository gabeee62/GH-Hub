extends CanvasGroup

var current_x: float = 1.0
var last_x: float = 1.0


func _process(_delta: float) -> void:
	reorder_spritelets()


func reorder_spritelets() -> void:
	if get_global_mouse_position().x > get_parent().global_position.x:
		current_x = 1.0
	elif get_global_mouse_position().x < get_parent().global_position.x:
		current_x = -1.0
	if current_x != last_x:
		last_x = current_x
		flip_sprite()


func flip_sprite() -> void:
	move_child(get_child(7), 3)
	move_child(get_child(7), 4)
	move_child(get_child(7), 5)
	move_child(get_child(7), 6)
	
	$LArms.flip_arms()
	$RArms.flip_arms()
	
	$Hat.flip_h = not $Hat.flip_h
	$Head.flip_h = not $Head.flip_h
	$Eyes.flip_h = not $Eyes.flip_h
	$LCloak.flip_h = not $LCloak.flip_h
	$RCloak.flip_h = not $RCloak.flip_h
	$Body.flip_h = not $Body.flip_h
	
	$LArms/LArm1.flip_v = not $LArms/LArm1.flip_v
	$LArms/LArm2.flip_v = not $LArms/LArm2.flip_v
	$RArms/RArm1.flip_v = not $RArms/RArm1.flip_v
	$RArms/RArm2.flip_v = not $RArms/RArm2.flip_v
