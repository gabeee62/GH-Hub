extends PanelContainer
class_name SaveSlot

var text: String

var save_slot_num: int


func _process(_delta: float) -> void:
	if $MarginContainer/Label.text != text:
		$MarginContainer/Label.text = text


func _on_button_pressed() -> void:
	SignalBus.save_chosen.emit(save_slot_num)
