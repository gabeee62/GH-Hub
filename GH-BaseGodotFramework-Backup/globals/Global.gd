extends Node

#               --- ABOUT ---
# This script acts as a global housing unit for 
# any important singletons you may want to keep
# track of (ex: the root node of the current scene,
# window size, etc.).

var WINDOW_SIZE: Vector2 = Vector2(1920, 1080)
var GAME_SPEED: float = 1.0
var FPS_LIMIT: int = 0

var ENGINE := GameEngine

var SAVE: SaveData
var MAIN: Main
var PLAYER: Player

var save_dir_path: String = "res://saves/"

var special_chars: Array[String] = [" ", "`", "~", ",", ".", "<", ">", "/", "?", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "=", "[", "]", "{", "}", ";", ":", "'", "\"", "\\", "|"]
