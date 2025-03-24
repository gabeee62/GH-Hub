extends Node2D
class_name Level

var player_scene: PackedScene = preload("res://scenes/entities/player/Player.tscn")

var DATA: LevelData


func _ready() -> void:
	DATA = load("res://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + name.to_lower() + ".tres")
	Globals.MAIN = self
	Globals.SAVE.CURRENT_LVL = scene_file_path
	
	var player: Player = player_scene.instantiate()
	player.position = Globals.SAVE.CURRENT_POS
	$Entities.add_child(player)
