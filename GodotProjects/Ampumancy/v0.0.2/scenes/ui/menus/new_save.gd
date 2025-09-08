extends Control

var forbidden_chars: Array[String] = [
	"!", "@", "#", "$", "%", "^", "&", "*", "(", ")",
	"=", "+", "[", "]", "{", "}", ";", ":", "'", "\"",
	"\\", "|", ",", ".", "<", ">", "/", "?", "`", "~",
	" "]
var forbidden_words: Array[String] = [
	"chink"]


func reset() -> void:
	hide()


func _on_confirm_start_pressed() -> void:
	for Name: String in [$Menu/SaveName.text, $Menu/PlayerName.text]:
		if Name == "":
			return
		for word in forbidden_words:
			if Name.to_lower() == word:
				return
		for character in Name.to_lower():
			for fchar in forbidden_chars:
				if character == fchar:
					return
	SaveHandler.create_new_save($Menu/SaveName.text, $Menu/PlayerName.text)
	SceneChanger.change_scene(Globals.SAVE.CURRENT_LVL)
