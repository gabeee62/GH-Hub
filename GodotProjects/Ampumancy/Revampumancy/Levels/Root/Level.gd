extends Node2D
class_name Level

@export var data: LevelData


func _ready() -> void:
	Singletons.level = self


func _process(delta: float) -> void:
	Singletons.player.move_data.current_tile = $EffectTerrain.get_cell_tile_data($EffectTerrain.local_to_map($EffectTerrain.to_local(Singletons.player.global_position + Vector2(0, 12))))


func connect_signals() -> void:
	SignalBus.PlayerSpawn.connect(_on_player_spawn)
	SignalBus.PlayerDeath.connect(_on_player_death)


func _on_player_spawn() -> void:
	pass


func _on_player_death() -> void:
	pass
