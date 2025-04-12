extends Control

var forbidden_chars: Array[String] = [
	"!", "@", "#", "$", "%", "^", "&", "*", "(", ")",
	"-", "_", "=", "+", "[", "]", "{", "}", ";", ":", 
	"'", "\"", "\\", "|", ",", ".", "<", ">", "/", "?", 
	"`", "~", " "]
var forbidden_words: Array[String] = [
	"chink"]

func reset() -> void:
	hide()

	
# FIX EXPORT SHIT "Can't open file from path ''."
func _on_confirm_start_pressed() -> void:
	for name: String in [$Menu/SaveName.text, $Menu/PlayerName.text]:
		if name == "":
			return
		for word in forbidden_words:
			if name.to_lower() == word:
				return
		for character in name.to_lower():
			for fchar in forbidden_chars:
				if character == fchar:
					return
	SaveHandler.create_new_save($Menu/SaveName.text, $Menu/PlayerName.text)
	SceneChanger.change_scene(Globals.SAVE.CURRENT_LVL)
