extends Resource
class_name PlayerStats

@export_group("Control Stats")
@export_subgroup("Movespeed/Ground")
@export var MOVESPEED: float
@export var DECEL: float
@export var ACCEL: float
@export_subgroup("Movespeed/Air")
@export var AIRMOVESPEED: float
@export var AIRDECEL: float
@export var AIRACCEL: float
@export_subgroup("Jump")
@export var MAX_DJUMPS: int
var DJUMPS: int
@export var JUMP_HEIGHT: float
@export var TIME_TO_PEAK: float
@export var TIME_TO_FALL: float
@export_group("", "")

@export_group("Game Stats")
@export_subgroup("Health")
@export var MAX_HEALTH: int
@export var HEALTH: int
@export var MAX_GOLD_HEALTH: int
@export var GOLD_HEALTH: int
@export_subgroup("Mana")
var MANA_LIMIT: int = 16
@export var MAX_MANA: int
@export var MANA: int
var MYSTIC_LIMIT: int = 16
@export var MAX_MYSTIC: int
@export var MYSTIC: int
var SOLAR_LIMIT: int = 16
@export var SOLAR: int
@export_subgroup("Attributes")
@export var CON: int
@export_group("", "")

@export_group("Modifiers")
@export_subgroup("Control Modifiers/Movespeed/Ground")
@export var MOD_SPEED: float
@export_subgroup("Control Modifiers/Movespeed/Air")
@export var MOD_AIRSPEED: float
@export_subgroup("Control Modifiers/Jump")
@export var MOD_HEIGHT: float
@export_subgroup("Game Modifiers")
@export var MOD_MAX_HEALTH: int
@export_subgroup("Game Modifiers/Attributes")
@export var MOD_CON: int
@export_group("", "")
