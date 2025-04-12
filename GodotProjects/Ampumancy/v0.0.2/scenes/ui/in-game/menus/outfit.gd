extends Control

@onready var HatLabel: Label = $PanelContainer/OutfitMenu/HBoxContainer/OutfitNums/Hat/Selection
@onready var HeadLabel: Label = $PanelContainer/OutfitMenu/HBoxContainer/OutfitNums/Head/Selection
@onready var EyesLabel: Label = $PanelContainer/OutfitMenu/HBoxContainer/OutfitNums/Eyes/Selection
@onready var CloakLabel: Label = $PanelContainer/OutfitMenu/HBoxContainer/OutfitNums/Cloak/Selection
@onready var BodyLabel: Label = $PanelContainer/OutfitMenu/HBoxContainer/OutfitNums/Body/Selection

@onready var HatPreview: Sprite2D = $PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Hat
@onready var HeadPreview: Sprite2D = $PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Head
@onready var EyesPreview: Sprite2D = $PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Eyes
@onready var CloakPreview: Sprite2D = $PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Cloak
@onready var BodyPreview: Sprite2D = $PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Body


func _process(_delta: float) -> void:
	HatPreview.texture = Refs.Hat[int(HatLabel.text) - 1]
	HeadPreview.texture = Refs.Head[int(HeadLabel.text) - 1]
	EyesPreview.texture = Refs.Eyes[int(EyesLabel.text) - 1]
	CloakPreview.texture = Refs.Cloak[int(CloakLabel.text) - 1]
	BodyPreview.texture = Refs.Body[int(BodyLabel.text) - 1]


func _on_hat_select_left_pressed() -> void:
	if int(HatLabel.text) > 1:
		HatLabel.text = str(int(HatLabel.text) - 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Hat.texture = Refs.Hat[int(HatLabel.text) - 1]


func _on_hat_select_right_pressed() -> void:
	if int(HatLabel.text) < 8:
		HatLabel.text = str(int(HatLabel.text) + 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Hat.texture = Refs.Hat[int(HatLabel.text) - 1]


func _on_head_select_left_pressed() -> void:
	if int(HeadLabel.text) > 1:
		HeadLabel.text = str(int(HeadLabel.text) - 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Head.texture = Refs.Head[int(HeadLabel.text) - 1]


func _on_head_select_right_pressed() -> void:
	if int(HeadLabel.text) < 8:
		HeadLabel.text = str(int(HeadLabel.text) + 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Head.texture = Refs.Head[int(HeadLabel.text) - 1]


func _on_eyes_select_left_pressed() -> void:
	if int(EyesLabel.text) > 1:
		EyesLabel.text = str(int(EyesLabel.text) - 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Eyes.texture = Refs.Eyes[int(EyesLabel.text) - 1]


func _on_eyes_select_right_pressed() -> void:
	if int(EyesLabel.text) < 8:
		EyesLabel.text = str(int(EyesLabel.text) + 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Eyes.texture = Refs.Eyes[int(EyesLabel.text) - 1]


func _on_cloak_select_left_pressed() -> void:
	if int(CloakLabel.text) > 1:
		CloakLabel.text = str(int(CloakLabel.text) - 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Cloak.texture = Refs.Cloak[int(CloakLabel.text) - 1]


func _on_cloak_select_right_pressed() -> void:
	if int(CloakLabel.text) < 8:
		CloakLabel.text = str(int(CloakLabel.text) + 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Cloak.texture = Refs.Cloak[int(CloakLabel.text) - 1]


func _on_body_select_left_pressed() -> void:
	if int(BodyLabel.text) > 1:
		BodyLabel.text = str(int(BodyLabel.text) - 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Body.texture = Refs.Body[int(BodyLabel.text) - 1]


func _on_body_select_right_pressed() -> void:
	if int(BodyLabel.text) < 8:
		BodyLabel.text = str(int(BodyLabel.text) + 1)
	$PanelContainer/OutfitMenu/HBoxContainer/Preview/CanvasGroup/Body.texture = Refs.Body[int(BodyLabel.text) - 1]


func _on_confirm_pressed() -> void:
	Globals.PLAYER.DATA.Hat = Refs.Hat[int(HatLabel.text) - 1]
	Globals.PLAYER.DATA.Head = Refs.Head[int(HeadLabel.text) - 1]
	Globals.PLAYER.DATA.Eyes = Refs.Eyes[int(EyesLabel.text) - 1]
	Globals.PLAYER.DATA.Cloak = Refs.Cloak[int(CloakLabel.text) - 1]
	Globals.PLAYER.DATA.Body = Refs.Body[int(BodyLabel.text) - 1]
	Globals.PLAYER.update_outfit()


func _on_visibility_changed() -> void:
	if visible:
		HatLabel.text = str(Refs.Hat.find(Globals.PLAYER.DATA.Hat) + 1)
		HeadLabel.text = str(Refs.Head.find(Globals.PLAYER.DATA.Head) + 1)
		EyesLabel.text = str(Refs.Eyes.find(Globals.PLAYER.DATA.Eyes) + 1)
		CloakLabel.text = str(Refs.Cloak.find(Globals.PLAYER.DATA.Cloak) + 1)
		BodyLabel.text = str(Refs.Body.find(Globals.PLAYER.DATA.Body) + 1)
