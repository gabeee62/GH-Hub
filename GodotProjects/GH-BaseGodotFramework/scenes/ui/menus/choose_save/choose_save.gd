extends Control

var title_screen_scene_path: String = "res://scenes/ui/menus/title_screen/title_screen.tscn"

var save_slot_scene: PackedScene = preload("res://scenes/ui/menus/choose_save/save_slot.tscn")

var save_dir: DirAccess = DirAccess.open(Global.save_dir_path)
var save_files: PackedStringArray = DirAccess.get_directories_at(Global.save_dir_path)


func _ready() -> void:
	SignalBus.save_chosen.connect(_on_save_chosen)
	var save_num: int = 0
	for dir in save_files:
		if dir != "default":
			var save_slot: SaveSlot = save_slot_scene.instantiate()
			save_slot.save_slot_num = save_num
			save_slot.text = dir
			save_num += 1
			
			$VBoxContainer/ScrollContainer/VBoxContainer.add_child(save_slot)


func _on_save_chosen(num: int):
	var chosen_save: SaveSlot = $VBoxContainer/ScrollContainer/VBoxContainer.get_child(num)
	SaveHandler.load_from_disk(Global.save_dir_path + chosen_save.text + "/save.tres")


func _on_back_pressed() -> void:
	SignalBus.change_scene.emit(title_screen_scene_path, Util.SCENE_CHANGE_TYPES.FB, false)
