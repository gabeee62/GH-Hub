extends Node2D
class_name PlayerSpawn

signal PlayerSpawned(player: Player)

@onready var ParentZone: Zone = $"../../.."
@onready var PlayerScene: PackedScene = preload("res://Server/Entity/Entities/Player/Entity_Player.tscn")


func _ready() -> void:
	connect("PlayerSpawned", ParentZone._on_player_spawned)


func set_new_spawn() -> void:
	Globals.CurrentSave.SpawnPoint = name


func spawn_player() -> void:
	var player: Player = PlayerScene.instantiate()
	PlayerSpawned.emit(player)
	player.global_position = global_position
