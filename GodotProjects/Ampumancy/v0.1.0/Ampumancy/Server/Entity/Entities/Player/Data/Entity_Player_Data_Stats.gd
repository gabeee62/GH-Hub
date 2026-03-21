extends Resource
class_name PlayerStatsData

@export_group("Health")
@export var Health: int = 100
@export var GoldHealth: int = 0

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
