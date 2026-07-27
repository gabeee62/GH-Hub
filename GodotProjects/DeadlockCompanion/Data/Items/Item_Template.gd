extends Resource
class_name Item

@export var Icon: Texture2D
@export var ItemName: String

enum ItemTypes {SPIRIT, VITALITY, WEAPON}
@export var type: ItemTypes

enum ItemTiers {I = 800, II = 1600, III = 3200, IV = 6400, LGNDRY = -1}
@export var tier: ItemTiers = ItemTiers.I

@export var UpgradesTo: Item
@export var UpgradesFrom: Item
