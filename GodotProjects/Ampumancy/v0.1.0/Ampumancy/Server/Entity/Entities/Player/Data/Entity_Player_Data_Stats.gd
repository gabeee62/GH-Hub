extends Resource
class_name PlayerStatsData

# Normal: The current value of the specified stat
# Max: The current value cap that the player's specified stat can reach; can be increased through gameplay
# HardCap: The highest value that the player's specified stat can be increased to

@export_group("Health")
@export var Health: int = 100
@export var GoldHealth: int = 0
@export var GoldAbsorption: float = 0.2

@export_subgroup("Max Values")
@export var MaxHealth: int = 100
@export var MaxGoldHealth: int = 0

var HealthHardCap: int = 200
var GoldHealthHardCap: int = 100

@export_group("Mana")
@export var ManaPoints: int = 0
@export var MysticPoints: int = 0
@export var SolarPoints: int = 0

@export_subgroup("Max Values")
@export var MaxManaPoints: int = 3
@export var MaxMysticPoints: int = 0
@export var MaxSolarPoints: int = 0

var ManaPointsHardCap: int = 16
var MysticPointsHardCap: int = 16
var SolarPointsHardCap: int = 8

@export_group("", "")
