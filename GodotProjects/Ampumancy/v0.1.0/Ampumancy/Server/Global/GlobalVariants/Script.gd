extends Node2D

var Settings: SettingsData

var CurrentSave: SaveData
var CurrentZone: Zone
var CurrentPlayer: Player

var TimePaused: int = 0
var StartTick: int
var PauseTick: int


func add_playtime() -> void:
	calculate_pausetime()
	if CurrentSave.PlayTime != -1:
		CurrentSave.PlayTime += (Time.get_ticks_msec() - StartTick) - TimePaused


func calculate_pausetime() -> void:
	if CurrentSave.PlayTime != -1:
		TimePaused += Time.get_ticks_msec() - PauseTick
