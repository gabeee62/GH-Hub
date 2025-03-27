extends Control

signal outfit_changed(hat: Texture2D, head: Texture2D, eyes: Texture2D, cloak: Texture2D, body: Texture2D)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		$OutfitBGPanel.hide()
		$MenuBGPanel.show()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_outfits_pressed() -> void:
	$MenuBGPanel.hide()
	$OutfitBGPanel.show()


func _on_return_to_title_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	$MenuBGPanel.hide()
	$QuitConfirm.show()


func _on_confirm_pressed() -> void:
	var hat = $OutfitBGPanel/Outfits/OutfitPreview/PreviewPanel/CanvasGroup/HatSprite.texture
	var head = $OutfitBGPanel/Outfits/OutfitPreview/PreviewPanel/CanvasGroup/HeadSprite.texture
	var eyes = $OutfitBGPanel/Outfits/OutfitPreview/PreviewPanel/CanvasGroup/EyesSprite.texture
	var cloak = $OutfitBGPanel/Outfits/OutfitPreview/PreviewPanel/CanvasGroup/CloakSprite.texture
	var body = $OutfitBGPanel/Outfits/OutfitPreview/PreviewPanel/CanvasGroup/BodySprite.texture
	outfit_changed.emit(hat, head, eyes, cloak, body)
	$OutfitBGPanel.hide()
	$MenuBGPanel.show()


func _on_outfits_back_pressed() -> void:
	$OutfitBGPanel.hide()
	$MenuBGPanel.show()


func _on_quit_yes_pressed() -> void:
	get_tree().quit()


func _on_quit_no_pressed() -> void:
	$QuitConfirm.hide()
	$MenuBGPanel.show()


func _on_menu_back_pressed() -> void:
	hide()
	get_tree().paused = false
