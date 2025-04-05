extends Label
class_name DamageMarker

var current_stacked_dmg: int = 0


func play_hit(damage: int) -> void:
	match Globals.SETTINGS.DMG_MARK_MODE:
		Util.DMG_MARK_MODES.SINGULAR:
			text = str(damage)
		Util.DMG_MARK_MODES.STACKING:
			current_stacked_dmg += damage
			text = str(current_stacked_dmg)
			$StackTimer.start()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("damage_taken")


func _on_stack_timer_timeout() -> void:
	current_stacked_dmg = 0
