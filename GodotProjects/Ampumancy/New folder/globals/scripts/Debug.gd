extends Node


func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("REFILLMANADB") and Globals.PLAYER:
			Globals.PLAYER.DATA.STATS.MANA = Globals.PLAYER.DATA.STATS.MAX_MANA
			Globals.PLAYER.DATA.STATS.MYSTIC = Globals.PLAYER.DATA.STATS.MAX_MYSTIC
		if event.is_action_pressed("REFILLJUMPBOOSTDB") and Globals.PLAYER:
			Globals.PLAYER.regen_boost(300)
