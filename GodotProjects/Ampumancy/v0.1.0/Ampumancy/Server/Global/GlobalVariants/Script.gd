extends Node2D

var CurrentSave: SaveData
var CurrentZone: Zone
var CurrentPlayer: Player

var TimePaused: int = 0
var StartTick: int
var PauseTick: int


func add_playtime() -> void:
	CurrentSave.PlayTime += (Time.get_ticks_msec() - StartTick) - TimePaused


func calculate_pausetime() -> void:
	TimePaused += Time.get_ticks_msec() - PauseTick
