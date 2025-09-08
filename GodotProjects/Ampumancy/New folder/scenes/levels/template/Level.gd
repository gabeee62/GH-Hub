extends Node2D
class_name Level

var player_scene: PackedScene = preload("res://scenes/entities/player/Player.tscn")
@onready var DATA: LevelData = load("user://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + name.to_lower() + ".tres")

var current_tile: TileData


func _ready() -> void:
	Globals.MAIN = self
	Globals.SAVE.CURRENT_LVL = scene_file_path
	update_canvas()
	
	SignalBus.player_ready.connect(_on_player_ready)
	var player: Player = player_scene.instantiate()
	player.position = Globals.SAVE.CURRENT_POS
	$Entities.add_child(player)
	
	SignalBus.level_ready.emit()


func _process(_delta: float) -> void:
	current_tile = $Terrain.get_cell_tile_data($Terrain.local_to_map($Terrain.to_local(Globals.PLAYER.global_position + Vector2(0, 70))))


func update_canvas() -> void:
	$CanvasLayers/SkyCanvas.set_new_parallax_bg(DATA.REGION.background_index)
	$CanvasModulate.color = DATA.REGION.canvas_modulate


func _on_player_ready() -> void:
	Globals.PLAYER.spell_cast.connect(_on_spell_cast)


func _on_spell_cast(spell: Node2D):
	$Spells.add_child(spell)
