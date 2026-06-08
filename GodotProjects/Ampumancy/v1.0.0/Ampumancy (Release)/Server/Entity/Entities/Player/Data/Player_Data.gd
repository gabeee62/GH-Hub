extends Resource
class_name PlayerData

@export var PlayerName: String

@export var Stats: StatsData = StatsData.new()
@export var Equipment: EquipmentData = EquipmentData.new()
@export var Inventory: InventoryData = InventoryData.new()

enum GroundStates {GROUNDED = 0, AIRBORNE = 1}
enum MovementStates {IDLE = 0, WALK = 1}

@export var GroundState: GroundStates = GroundStates.GROUNDED
@export var MovementState: MovementStates = MovementStates.IDLE

var WasFacing: float = 1.0

@export var BaseMoveSpeed: float = 150.0
@export var MaxMoveSpeed: float = 300.0
@export var GroundAcceleration: float = 35.0
@export var GroundFriction: float = 40.0

@export var BaseAirSpeed: float = 130.0
@export var MaxAirSpeed: float = 270.0
@export var AirAcceleration: float = 25.0
@export var AirFriction: float = 20.0

@export var JumpHeight: float
@export var TimeToPeak: float
@export var TimeToFall: float
