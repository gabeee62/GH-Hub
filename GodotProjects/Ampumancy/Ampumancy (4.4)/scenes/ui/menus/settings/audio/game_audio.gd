@tool
extends MarginContainer

@onready var master_vol: HBoxContainer = $ScrollContainer/VBoxContainer/MasterVolume
@onready var music_vol: HBoxContainer = $ScrollContainer/VBoxContainer/MusicVolume
@onready var sfx_vol: HBoxContainer = $ScrollContainer/VBoxContainer/SFXVolume



func _ready() -> void:
	if not Engine.is_editor_hint():
		master_vol.get_child(1).value = Globals.SETTINGS.AUDIO_SETTINGS.game_master_vol
		music_vol.get_child(1).value = Globals.SETTINGS.AUDIO_SETTINGS.game_music_vol
		sfx_vol.get_child(1).value = Globals.SETTINGS.AUDIO_SETTINGS.game_sfx_vol


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		Globals.SETTINGS.AUDIO_SETTINGS.game_master_vol = master_vol.get_child(1).value
		Globals.SETTINGS.AUDIO_SETTINGS.game_music_vol = music_vol.get_child(1).value
		Globals.SETTINGS.AUDIO_SETTINGS.game_sfx_vol = sfx_vol.get_child(1).value
		
	for child in $ScrollContainer/VBoxContainer.get_children():
		if child is HBoxContainer and child.get_child(1) is HSlider:
			child.get_child(2).text = str(int(child.get_child(1).value))
