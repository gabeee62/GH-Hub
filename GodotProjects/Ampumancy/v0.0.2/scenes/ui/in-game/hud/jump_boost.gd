extends PanelContainer


func _process(_delta: float) -> void:
	update_bar_value()


func update_bar_value() -> void:
	get_tree().create_tween().tween_property($TextureProgressBar, "value", 100 * Globals.PLAYER.DATA.STATS.JUMP_BOOST / Globals.PLAYER.DATA.STATS.MAX_JUMP_BOOST, 0.2)
