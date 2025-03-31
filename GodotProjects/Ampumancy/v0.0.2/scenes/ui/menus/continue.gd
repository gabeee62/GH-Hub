extends Control

var save_slot_scene: PackedScene = preload("res://scenes/ui/menus/save_slot.tscn")


func _ready() -> void:
	SignalBus.save_chosen.connect(_on_save_chosen)
	
	var save_files: PackedStringArray = DirAccess.get_directories_at("res://saves/")
	for save: String in save_files:
		if save != "default":
			var new_slot: PanelContainer = save_slot_scene.instantiate()
			var data: SaveData = ResourceLoader.load("res://saves/" + save + "/save.tres")
			new_slot.get_child(3).get_child(0).text = str(data.SAVENAME)
			new_slot.get_child(3).get_child(1).text = str(data.PLAYER.NAME)
			# new_slot.get_child(3).get_child(2).text = str(data.PLAYTIME) -- WIP
		
			$Menu/SaveSlots/VBoxContainer/ScrollMenu/VBoxContainer.add_child(new_slot)


func _on_save_chosen(save_name: String):
	SaveHandler.load_from_disk(save_name)
	SceneChanger.change_scene(Globals.SAVE.CURRENT_LVL)


func reset() -> void:
	hide()
