extends Control


func reset() -> void:
	$Buttons.show()
	$Video.reset()
	$Audio.reset()
	$Controls.reset()
	hide()
