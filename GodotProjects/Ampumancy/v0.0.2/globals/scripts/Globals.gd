extends Node

var WINDOW_SIZE: Vector2 = Vector2(1920, 1080)
var MAX_ZOOM: float = 1.0
var MIN_ZOOM: float = 1.0
var GAME_STATE: Util.GAME_STATES = Util.GAME_STATES.RUNNING
var GAME_SPEED: float = 1.0

var MAIN: Level
var PLAYER: Player
var DEFAULT_SAVE: SaveData = preload("res://saves/default/save.tres")
var SAVE: SaveData
var SETTINGS: SettingsData = preload("res://data/settings/Settings.tres")

var ITEMS: ItemLib = preload("res://data/items/ItemLibrary.tres")


func _ready() -> void:
	SAVE = DEFAULT_SAVE
	process_mode = Node.PROCESS_MODE_ALWAYS
