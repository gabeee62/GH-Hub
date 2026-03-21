extends Control

var MenuOrDesk: bool

@onready var MainMenu: String = "res://Server/UI/Menu/Menus/Title Screen/Menu_TitleScreen.tscn"
@onready var Selections = $WardrobeMenu/ColorRect/MarginContainer/HBoxContainer/Selections
@onready var WardrobePreview: SelectionPreview = $WardrobeMenu/ColorRect/MarginContainer/HBoxContainer/SelectionPreview/ColorRect/SelectionPreview


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GAME_PAUSE"):
		reset()


func _process(_delta: float) -> void:
	WardrobePreview.Selections = get_wardrobe_selections()


func reset() -> void:
	$OptionsMenu.hide()
	$WardrobeMenu.hide()
	$ModsMenu.hide()
	$SaveMenu.hide()
	$Buttons.show()


func _on_options_pressed() -> void:
	$Buttons.hide()
	$OptionsMenu.show()


func _on_wardrobe_pressed() -> void:
	#for i: WardrobeSelectButton in Selections.get_children():
	#	i.reset()
	#$Buttons.hide()
	#$WardrobeMenu.show()
	pass


func _on_mods_pressed() -> void:
	$Buttons.hide()
	$ModsMenu.show()


func _on_menu_quit_pressed() -> void:
	MenuOrDesk = true
	$Buttons.hide()
	$SaveMenu.show()
	# TODO: Make scene changer and transition to main menu


func _on_desktop_quit_pressed() -> void:
	MenuOrDesk = false
	$Buttons.hide()
	$SaveMenu.show()


func _on_save_yes_pressed() -> void:
	get_tree().paused = false
	Globals.calculate_pausetime()
	Globals.add_playtime()
	SaveHandler.save_game(Globals.CurrentSave)
	menu_or_desk_quit()


func _on_save_no_pressed() -> void:
	get_tree().paused = false
	menu_or_desk_quit()


func menu_or_desk_quit() -> void:
	if MenuOrDesk:
		SceneChanger.play_screen_transition("GameFadeToBlack")
	else:
		get_tree().quit()


func _on_save_back_pressed() -> void:
	$SaveMenu.hide()
	$Buttons.show()


func _on_back_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_wardrobe_confirm_pressed() -> void:
	Globals.CurrentSave.Player_Data.WardrobeSelection = get_wardrobe_selections()
	$WardrobeMenu.hide()
	$Buttons.show()


func _on_wardrobe_back_pressed() -> void:
	for i: WardrobeSelectButton in $WardrobeMenu/ColorRect/MarginContainer/HBoxContainer/Selections.get_children():
		i.WardrobePartValue = Globals.CurrentSave.Player_Data.WardrobeSelection[i.WardrobePartPosition]
	$WardrobeMenu.hide()
	$Buttons.show()


func get_wardrobe_selections() -> Array[int]:
	var array: Array[int]
	for i: WardrobeSelectButton in $WardrobeMenu/ColorRect/MarginContainer/HBoxContainer/Selections.get_children():
		array.append(i.WardrobePartValue)
	return array
