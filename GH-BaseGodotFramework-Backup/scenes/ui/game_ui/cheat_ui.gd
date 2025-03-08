extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("COMMAND_UI"):
		visible = not visible
		SignalBus.pause_game.emit()
		# $LineEdit.focus_mode = 


func _on_line_edit_text_submitted(new_text: String) -> void:
	SignalBus.cheat_entered.emit(new_text)
	$LineEdit.text = ""
