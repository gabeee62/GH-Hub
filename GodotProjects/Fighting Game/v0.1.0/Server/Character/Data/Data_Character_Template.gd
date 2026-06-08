extends Resource
class_name CharacterData

enum Roles {ASSASSIN, BRUISER, MAGE, RUSHDOWN, SUPPORT, TANK, ZONER}

@export_group("Character Information")
@export var Name: String
@export var Role: Roles

@export_subgroup("Stats")
@export var Level: int = 1

@export_subgroup("Stats/Combat")

@export_subgroup("Stats/Movement")

@export_subgroup("Stats/Base Values")
@export_subgroup("Stats/Base Values/Combat")
@export var BaseStrength: Array[int]
@export var BaseAttunement: Array[int]
@export_subgroup("Stats/Base Values/Movement")
@export var BaseWalkSpeed: float
@export var BaseRunSpeed: float
@export var BaseDashDistance: float
