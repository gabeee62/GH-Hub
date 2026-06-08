extends Resource
class_name SaveData

@export var SaveName: String

@export var Developer: bool = false

@export var PlayTime: int

@export var Player_Data: PlayerData

@export var CurrentZone: String = "res://Server/Zone/Zones/Overworld/Zone_Overworld.tscn"
@export var SpawnPoint: String = "GameStartSpawn"

# TODO: Zone-specific save data needs to go here (preload) when done
@export_group("ZoneData")
@export var Zone1: ZoneData
@export var Zone2: ZoneData
@export var Zone3: ZoneData
