extends Control

var save_slot_scene: PackedScene = preload("res://scenes/ui/menus/save_slot.tscn")


func _ready() -> void:
	SignalBus.save_chosen.connect(_on_save_chosen)
	SignalBus.slot_freed.connect(_on_slot_freed)
	
	var save_files: PackedStringArray = DirAccess.get_directories_at("user://saves/")
	for save: String in save_files:
		var new_slot: PanelContainer = save_slot_scene.instantiate()
		var data: SaveData = ResourceLoader.load("user://saves/" + save + "/save.tres")
		new_slot.get_child(2).get_child(0).get_child(0).text = str(data.SAVENAME)
		new_slot.get_child(2).get_child(0).get_child(1).text = str(data.PLAYER.NAME)
		new_slot.get_child(2).get_child(0).get_child(2).text = msec_to_time(data.PLAYTIME)
		
		if $Menu/SaveSlots/ScrollMenu.custom_minimum_size.y < 300:
			$Menu/SaveSlots/ScrollMenu.custom_minimum_size.y += 50
	
		$Menu/SaveSlots/ScrollMenu/VBoxContainer.add_child(new_slot)


func msec_to_time(msecs: int) -> String:
	@warning_ignore("integer_division")
	var hours: int = msecs / 3600000
	msecs -= hours * 3600000
	@warning_ignore("integer_division")
	var mins: int = msecs / 60000
	msecs -= mins * 60000
	@warning_ignore("integer_division")
	var secs: int = msecs / 1000
	return dd(hours) + ":" + dd(mins) + ":" + dd(secs)


func dd(num: int) -> String:
	if len(str(num)) < 2:
		return "0" + str(num)
	else:
		return str(num)


func _on_save_chosen(save_name: String):
	SaveHandler.load_from_disk(save_name)
	SceneChanger.change_scene(Globals.SAVE.CURRENT_LVL)


func _on_slot_freed(slot: SaveSlot) -> void:
	SaveHandler.delete_from_disk(slot.get_child(2).get_child(0).get_child(0).text)
	slot.queue_free()
	if len($Menu/SaveSlots/ScrollMenu/VBoxContainer.get_children()) < 6 and len($Menu/SaveSlots/ScrollMenu/VBoxContainer.get_children()) > 0:
		$Menu/SaveSlots/ScrollMenu.custom_minimum_size.y -= 50


func reset() -> void:
	hide()
