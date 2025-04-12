extends PanelContainer


func _process(_delta: float) -> void:
	update_bar_value()


func update_bar_value() -> void:
	get_tree().create_tween().tween_property($VBoxContainer/JumpBoostBar1, "value", Globals.PLAYER.DATA.STATS.JUMP_BOOST, 0.25)
	if Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST > 100 and Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST <= 200:
		$VBoxContainer/JumpBoostBar2.visible = true
		$VBoxContainer/JumpBoostBar3.visible = false
		$VBoxContainer/JumpBoostBar2.custom_minimum_size = Vector2(8, ((Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST - 100) * 8) / 25.0)
		get_tree().create_tween().tween_property($VBoxContainer/JumpBoostBar2, "value", 100.0 * (Globals.PLAYER.DATA.STATS.JUMP_BOOST - 100) / (Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST - 100), 0.25)
	elif Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST > 200:
		$VBoxContainer/JumpBoostBar2.visible = true
		$VBoxContainer/JumpBoostBar3.visible = true
		$VBoxContainer/JumpBoostBar2.custom_minimum_size = Vector2(8, 32)
		$VBoxContainer/JumpBoostBar3.custom_minimum_size = Vector2(8, ((Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST - 200) * 8) / 25.0)
		get_tree().create_tween().tween_property($VBoxContainer/JumpBoostBar2, "value", Globals.PLAYER.DATA.STATS.JUMP_BOOST - 100, 0.25)
		get_tree().create_tween().tween_property($VBoxContainer/JumpBoostBar3, "value", 100.0 * (Globals.PLAYER.DATA.STATS.JUMP_BOOST - 200) / (Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST - 200), 0.25)
	else:
		$VBoxContainer/JumpBoostBar2.visible = false
		$VBoxContainer/JumpBoostBar3.visible = false
