class_name PlayerData extends Resource

enum GroundStates {GROUNDED = 0, AIRBORNE = 1}
enum MoveStates {IDLE, WALK, RUN}

@export_group("Movement")
@export_subgroup("States")
@export var ground_state: GroundStates
@export var move_state: MoveStates
@export_subgroup("Ground Movement")
@export var movespeed: float
@export var runspeed: float
@export var acceleration: float
@export var friction: float
@export_subgroup("Air Movement")
@export var air_movespeed: float
@export var air_acceleration: float
@export var air_friction: float
@export_group("", "")
