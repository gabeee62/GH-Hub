extends Resource
class_name PlayerData

@export var current_level: int
@export var save_pos: Vector2


@export_group("Movement")
@export var movespeed: int = 150
@export_subgroup("Jump")
@export var jump_velocity: float = -750.0
@export var jump_gravity: float = 3750.0
@export var fall_gravity: float = 1667.667
@export var max_double_jumps: int
var double_jumps: int
@export_group("")

@export var inventory: InventoryData
