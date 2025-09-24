extends Resource
class_name ItemData

enum ItemType {MATERIAL, CONSUMABLE, EQUIPMENT}

@export var name: String
@export var texture: Texture2D

@export var type: ItemType

@export var max_stack: int
