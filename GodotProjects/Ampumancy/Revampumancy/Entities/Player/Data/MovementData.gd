extends Resource
class_name MovementData

enum AirStates {GROUNDED, JUMP, FALL, HIT}
enum GroundStates {IDLE, WALK, SPRINT}

var current_tile: TileData

var ground_state: GroundStates = GroundStates.IDLE
var last_ground_state: GroundStates = GroundStates.IDLE
var air_state: AirStates = AirStates.GROUNDED
var last_air_state: AirStates = AirStates.GROUNDED

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

var input_vector: Vector2
var look_direction: int
var last_look_direction: int

# TODO: Integrate mod values into movement calculations
@export_group("Ground Movement")
var true_movespeed: float
@export var movespeed_mod: float  = 0.0 # Increases player walk speed by the specified percentage
@export var override_movespeed: float = 0.0 # Used as a temporary higher-priority movespeed value; substitutes the original movespeed variable
@export var movespeed: float
var true_sprintspeed: float
@export var sprintspeed_mod: float
@export var override_sprintspeed: float
@export var sprintspeed: float
var true_accel: float
@export var accel_mod: float
@export var override_accel: float
@export var accel: float
var true_decel: float
@export var decel_mod: float
@export var override_decel: float
@export var decel: float

@export_group("Air Movement")
var true_air_movespeed: float
@export var air_movespeed_mod: float
@export var override_air_movespeed: float
@export var air_movespeed: float
var true_air_accel: float
@export var air_accel_mod: float
@export var override_air_accel: float
@export var air_accel: float
var true_air_decel: float
@export var air_decel_mod: float
@export var override_air_decel: float
@export var air_decel: float
@export_subgroup("Jump Variables")
var true_gravity: float
@export var gravity_mod: float
var true_jump_height: float
@export var jump_height_mod: float
@export var override_jump_height: float
@export var jump_height: float
var true_ttp: float
@export var time_to_peak_mod: float
@export var override_time_to_peak: float
@export var time_to_peak: float
var true_ttl: float
@export var time_to_land_mod: float
@export var override_time_to_land: float
@export var time_to_land: float
@export var temp_double_jumps: int
@export var max_double_jumps: int
var current_double_jumps: int


func get_true_mod_value(mod: float, override: float) -> float:
	if override == 0.0:
		return 1 + mod
	else:
		return override
