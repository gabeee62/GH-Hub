extends Node

var WINDOW_SIZE: Vector2 = Vector2(1280, 720)
var MAX_ZOOM: float = 2.5
var MIN_ZOOM: float = 0.6
var GAME_STATE: Util.GAME_STATES = Util.GAME_STATES.RUNNING
var GAME_SPEED: float = 1.0

var MAIN: Level
var SAVE: SaveData = preload("res://saves/default/save.tres")
var SETTINGS: SettingsData = preload("res://data/settings/Settings.tres")
var PLAYER: Player
