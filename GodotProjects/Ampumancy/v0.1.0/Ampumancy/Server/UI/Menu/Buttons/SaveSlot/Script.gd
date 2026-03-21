extends Button
class_name SaveSlotButton

var Data: SaveData

var DeleteStatus: int = 0


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				if DeleteStatus == 0:                                           # SAVE QUEUED FOR DELETION
					DeleteStatus += 1
					$MarginContainer/DeleteLabel.show()
				else:                                                           # SAVE DELETION CANCELLED
					DeleteStatus -= 1
					$MarginContainer/DeleteLabel.hide()    
			if event.button_index == MOUSE_BUTTON_LEFT:
				if DeleteStatus == 0:                                           # GAME STARTED WITH CHOSEN SAVE
					Globals.CurrentSave = Data
					SceneChanger.play_screen_transition("MenuFadeToBlack")
				elif DeleteStatus == 1:                                         # SAVE DELETED
					SaveHandler.delete_save(Data)
					queue_free()


func set_label_text(SaveName: String) -> void:
	$MarginContainer/SaveName.text = SaveName


func set_playtime() -> void:
	var playtime: int = Data.PlayTime
	var hours: int
	var minutes: int
	var seconds: int
	if playtime > 3600000:
		@warning_ignore("integer_division")
		hours = playtime / 3600000
		playtime -= hours * 3600000
	if playtime > 60000:
		@warning_ignore("integer_division")
		minutes = playtime / 60000
		playtime -= minutes * 60000
	if playtime > 1000:
		@warning_ignore("integer_division")
		seconds = playtime / 1000
	$MarginContainer/PlayTime.text = double_digify(hours) + " : " + double_digify(minutes) + " : " + double_digify(seconds)


func double_digify(num: int) -> String:
	if not num > 0:
		return "00"
	elif num > 0 and num < 10:
		return "0" + str(num)
	else:
		return str(num)


func _on_focus_exited() -> void:
	DeleteStatus = 0
	$MarginContainer/DeleteLabel.hide()
