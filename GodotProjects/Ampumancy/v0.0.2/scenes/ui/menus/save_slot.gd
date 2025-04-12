extends PanelContainer
class_name SaveSlot


func _on_clickable_pressed() -> void:
	SignalBus.save_chosen.emit($TextContainer/HBoxContainer/SaveName.text)


func _on_clickable_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("RMB"):
		$TrashButton.show()


func _on_clickable_focus_exited() -> void:
	$TrashButton.hide()
	$TrashConfirmButton.hide()


func _on_trash_button_pressed() -> void:
	$TrashConfirmButton.show()


func _on_trash_confirm_button_pressed() -> void:
	SignalBus.slot_freed.emit(self)
