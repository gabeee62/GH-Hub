extends Label

signal text_updated(value: String)


func _on_menu_left_pressed() -> void:
	if int(text) > 1:
		text = str(int(text) - 1)
	text_updated.emit(text)


func _on_menu_right_pressed() -> void:
	if int(text) < 8:
		text = str(int(text) + 1)
	text_updated.emit(text)
