extends Control


func reset() -> void:
	$Buttons.show()
	$Video.hide()
	$Audio.hide()
	$Controls.hide()
	hide()
