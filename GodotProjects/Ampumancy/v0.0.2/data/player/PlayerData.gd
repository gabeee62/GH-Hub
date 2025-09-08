extends Resource
class_name PlayerData

@export var NAME: String

@export_group("Game Data")
@export var STATS: PlayerStats = PlayerStats.new()
@export var INVENTORY: InvData = InvData.new()
@export var EQUIPMENT: EquipData = EquipData.new()
@export var STATES: PlayerStates = PlayerStates.new()
@export_group("", "")

@export_group("Outfit")
@export var Hat: Texture2D
@export var Head: Texture2D
@export var Eyes: Texture2D
@export var Cloak: Texture2D
@export var Body: Texture2D
@export_group("", "")
