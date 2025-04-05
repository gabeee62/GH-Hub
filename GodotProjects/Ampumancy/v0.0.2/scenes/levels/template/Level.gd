extends Node2D
class_name Level

@export var background_index: int = 1

var player_scene: PackedScene = preload("res://scenes/entities/player/Player.tscn")

@onready var DATA: LevelData = load("res://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + name.to_lower() + ".tres")


func _ready() -> void:
	#DATA = load("res://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + name.to_lower() + ".tres")
	Globals.MAIN = self
	Globals.SAVE.CURRENT_LVL = scene_file_path
	$CanvasLayers/BGCanvas.set_new_parallax_bg(DATA.REGION.background_index)
	
	SignalBus.player_ready.connect(_on_player_ready)
	var player: Player = player_scene.instantiate()
	player.position = Globals.SAVE.CURRENT_POS
	$Entities.add_child(player)
	
	SignalBus.level_ready.emit()


func _on_player_ready() -> void:
	Globals.PLAYER.spell_cast.connect(_on_spell_cast)


func _on_spell_cast(spell: Node2D):
	$Spells.add_child(spell)
