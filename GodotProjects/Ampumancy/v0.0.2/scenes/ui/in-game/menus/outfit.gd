extends Control

@onready var HatLabel: Label = $OutfitMenu/HBoxContainer/OutfitNums/Hat/Name
@onready var HeadLabel: Label = $OutfitMenu/HBoxContainer/OutfitNums/Head/Name
@onready var EyesLabel: Label = $OutfitMenu/HBoxContainer/OutfitNums/Eyes/Name
@onready var CloakLabel: Label = $OutfitMenu/HBoxContainer/OutfitNums/Cloak/Name
@onready var BodyLabel: Label = $OutfitMenu/HBoxContainer/OutfitNums/Body/Name

var player_ready: bool = false


func _ready() -> void:
	SignalBus.player_ready.connect(set_player_ready)


func set_player_ready() -> void:
	player_ready = not player_ready


func _on_select_left_pressed() -> void:
	pass


func _on_select_right_pressed() -> void:
	pass
