extends Resource
class_name PlayerData

@export var name: String

@export var stats: PlayerStats

@export_group("Platformer Control Variables")
@export var WALKSPEED: float
@export var RUNSPEED: float
@export var AIRSPEED: float
@export var ACCELERATION: float
@export var DECELERATION: float
@export var AIR_ACCELERATION: float
@export var AIR_DECELERATION: float
@export var MAX_EXTRA_JUMPS: int
var EXTRA_JUMPS: int
@export var JUMP_HEIGHT: float
@export var TIME_TO_PEAK: float
@export var TIME_TO_LAND: float
@export_group("", "")

@export_group("Topdown Control Variables")
@export var TDWALKSPEED: float
@export var TDACCEL: float
@export var TDDECEL: float
@export_group("", "")
