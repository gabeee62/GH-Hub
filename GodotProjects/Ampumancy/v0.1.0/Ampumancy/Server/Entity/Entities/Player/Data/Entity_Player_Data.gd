extends Resource
class_name PlayerData

enum GroundStates {GROUNDED, AIRBORNE}

@export_group("Character")
@export var CharacterName: String = "The Exiled"
@export var Wardrobe: PlayerWardrobeData = PlayerWardrobeData.new()
@export var Stats: PlayerStatsData = PlayerStatsData.new()
@export var Equipment: PlayerEquipmentData = PlayerEquipmentData.new()
@export var Inventory: PlayerInventoryData = PlayerInventoryData.new()

@export_subgroup("Mana")
@export var ManaUnlocked: bool = false
@export var ManaEnabled: bool = true

@export_subgroup("Movement")
var ControlLocked: bool = false

@export_group("Movement")
var GroundState: GroundStates = GroundStates.GROUNDED
var LastFaced: float = 1.0

@export_subgroup("Ground")
@export var MoveSpeed: float = 175.0
var MoveSpeedMod: float = 0.0
var MoveSpeedOverride: float = 0.0
@export var Acceleration: float = 30.0
var AccelerationMod: float = 0.0
var AccelerationOverride: float = 0.0
@export var Deceleration: float = 30.0
var DecelerationMod: float = 0.0
var DecelerationOverride: float = 0.0

@export_subgroup("Air")
@export var AirSpeed: float = 175.0
var AirSpeedMod: float = 0.0
var AirSpeedOverride: float = 0.0
@export var AirAcceleration: float = 30.0
var AirAccelerationMod: float = 0.0
var AirAccelerationOverride: float = 0.0
@export var AirDeceleration: float = 30.0
var AirDecelerationMod: float = 0.0
var AirDecelerationOverride: float = 0.0

@export_subgroup("Air/Jump")
@export var MaxDoubleJumps: int = 1
var MaxDoubleJumpsMod: int = 0
var MaxDoubleJumpsOverride: int = 0
var CurrentDoubleJumps: int
@export var JumpHeight: float = 75
var JumpHeightMod: float = 0.0
var JumpHeightOverride: float = 0.0
@export var TimeToPeak: float = 0.3
var TimeToPeakMod: float = 0.0
var TimeToPeakOverride: float = 0.0
@export var TimeToLand: float = 0.25
var TimeToLandMod: float = 0.0
var TimeToLandOverride: float = 0.0

var FastFallMultiplier: float = 1.0
var FastFalling: bool = false

var JumpVelocity: float
var JumpGravity: float
var FallGravity: float
