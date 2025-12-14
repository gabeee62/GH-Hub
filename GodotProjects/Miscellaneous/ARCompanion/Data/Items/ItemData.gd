extends Resource
class_name ItemData

@export var tags: TagData

enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}
@export var rarity: Rarity

@export var max_per_stack: int

@export var sell_price: int

@export var weight: float

@export var craftable: bool
@export var recipe: RecipeData

@export var recyclable: bool
@export var recycle: RecycleData
@export var salvage: RecycleData
