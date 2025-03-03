extends Node

var save_path: String = "res://saves/game_saves/"

func create_new_save_file():
	var new_save: SaveData = SaveData.new()
	var filename: String


func load_save_file(save_data: SaveData):
	pass


func save_file_to_disk(filename: String):
	pass
