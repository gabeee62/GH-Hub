extends ItemData
class_name WeaponData

enum WeaponType {SEMI_AUTO, FULL_AUTO, TWO_BURST, THREE_BURST, SINGLE_ACTION, BREAK_ACTION, BOLT_ACTION, LEVER_ACTION, SLIDE_ACTION, PUMP_ACTION}
enum WeaponAmmo {LIGHT, SHOTGUN, MEDIUM, HEAVY, ENERGY, LAUNCHER}
enum Penetration {VERY_WEAK, WEAK, MODERATE, STRONG, VERY_STRONG}

@export var type: WeaponType
@export var ammo: WeaponAmmo
@export var penetration: Penetration

@export var attributes: AttributeData
@export var attachments: AttachmentSlotData

@export_group("Stats Per Level")
@export_subgroup("Upgrade Recipes")
@export var level_2_recipe: RecipeData
@export var level_3_recipe: RecipeData
@export var level_4_recipe: RecipeData
@export_subgroup("Recycle Returns")
@export var level_2_recycle: RecycleData
@export var level_3_recycle: RecycleData
@export var level_4_recycle: RecycleData
@export_subgroup("Salvage Returns")
@export var level_2_salvage: RecycleData
@export var level_3_salvage: RecycleData
@export var level_4_salvage: RecycleData
@export_subgroup("Sell Prices")
@export var level_2_sell_price: int
@export var level_3_sell_price: int
@export var level_4_sell_price: int
@export_group("", "")
