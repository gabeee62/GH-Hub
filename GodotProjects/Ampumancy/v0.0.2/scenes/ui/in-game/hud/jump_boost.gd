extends PanelContainer

var bar1_depleted: bool = false
var bar2_depleted: bool = false
var bar3_depleted: bool = false


func _process(_delta: float) -> void:
	update_bar_value()
	flash_on_depletion()


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


func flash_on_depletion() -> void:
	if not bar3_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST < 201:
		bar3_depleted = true
		$AnimationPlayer.play("bar3_flash")
	elif bar3_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST > 200:
		bar3_depleted = false
	if not bar2_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST < 101:
		bar2_depleted = true
		$AnimationPlayer.play("bar2_flash")
	elif bar2_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST > 100:
		bar2_depleted = false
	if not bar1_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST == 0:
		bar1_depleted = true
		$AnimationPlayer.play("bar1_flash")
	elif bar1_depleted and Globals.PLAYER.DATA.STATS.JUMP_BOOST != 0:
		bar1_depleted = false
