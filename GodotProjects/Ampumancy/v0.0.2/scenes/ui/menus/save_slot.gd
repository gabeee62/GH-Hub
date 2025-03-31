extends PanelContainer


func _on_clickable_pressed() -> void:
	SignalBus.save_chosen.emit($MarginContainer/SaveName.text)
