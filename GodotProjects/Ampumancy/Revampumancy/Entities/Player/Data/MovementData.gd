extends Resource
class_name MovementData

enum GroundStates {IDLE, WALK, SPRINT}
enum AirStates {GROUNDED, JUMP, FALL}

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
var movespeed_mod: float # Increases player walk speed by the specified percentage
var override_movespeed: float # Used as a temporary higher-priority movespeed value; substitutes the original movespeed variable
@export var movespeed: float
var sprintspeed_mod: float
var override_sprintspeed: float
@export var sprintspeed: float
var accel_mod: float
var override_accel: float
@export var accel: float
var decel_mod: float
var override_decel: float
@export var decel: float

@export_group("Air Movement")
var air_movespeed_mod: float
var override_air_movespeed: float
@export var air_movespeed: float
var air_accel_mod: float
var override_air_accel: float
@export var air_accel: float
var air_decel_mod: float
var override_air_decel: float
@export var air_decel: float
@export_subgroup("Jump Variables")
var gravity_mod: float
var jump_height_mod: float
var override_jump_height: float
@export var jump_height: float
var time_to_peak_mod: float
var override_time_to_peak: float
@export var time_to_peak: float
var time_to_land_mod: float
var override_time_to_land: float
@export var time_to_land: float
var temp_double_jumps: int
@export var max_double_jumps: int
var current_double_jumps: int
