extends Control

var title_or_desktop: bool


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PAUSE"):
		SignalBus.pause_game.emit()
		visible = not visible
		$SaveAndConfirm.hide()


func _on_back_pressed() -> void:
	SignalBus.pause_game.emit()
	visible = not visible
	$SaveAndConfirm.hide()


# TODO: Make options menu for title screen
func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_menu_quit_pressed() -> void:
	title_or_desktop = true
	$PauseMenu.visible = false
	$SaveAndConfirm.visible = true


func _on_desktop_quit_pressed() -> void:
	title_or_desktop = false
	$PauseMenu.visible = false
	$SaveAndConfirm.visible = true


func _on_yes_button_pressed() -> void:
	$SaveAndConfirm.hide()
	SignalBus.pause_game.emit()
	SignalBus.quit_game.emit(title_or_desktop, true)


func _on_no_button_pressed() -> void:
	$SaveAndConfirm.hide()
	SignalBus.pause_game.emit()
	SignalBus.quit_game.emit(title_or_desktop, false)


func _on_quit_back_pressed() -> void:
	$SaveAndConfirm.hide()
	$PauseMenu.visible = true
