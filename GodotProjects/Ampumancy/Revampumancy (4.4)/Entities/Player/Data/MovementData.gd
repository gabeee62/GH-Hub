extends Resource
class_name MovementData

@export_group("Ground Movement")
@export var movespeed: float
@export var sprintspeed: float
@export var accel: float
@export var decel: float

@export_group("Air Movement")
@export var air_movespeed: float
@export var air_accel: float
@export var air_decel: float
@export_subgroup("Jump Variables")
@export var jump_height: float
@export var time_to_peak: float
@export var time_to_land: float
@export var max_double_jumps: int
var current_double_jumps: int
