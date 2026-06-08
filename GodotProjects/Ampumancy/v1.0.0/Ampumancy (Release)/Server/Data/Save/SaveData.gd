extends Resource
class_name SaveData

enum Difficulties {NORMAL = 0, HARD = 1, HARDCORE = 2, GODLIKE = 4}
enum Modifiers {NONE = 0, DEBUG = -1}

@export var Difficulty: Difficulties
@export var modifiers: Modifiers

@export var SaveName: String

@export var CurrentZone: float # FIXME: Replace when zone template is made
@export var CurrentPosition: Vector2

@export var Stats: StatsData
@export var Equipment: EquipmentData
@export var Inventory: InventoryData
