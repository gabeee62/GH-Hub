extends Resource
class_name Stats

# OUTFITS
@export var hat_color: int
@export var head_color: int
@export var eye_color: int
@export var cloak_color: int
@export var body_color: int

# MOVEMENT VARIABLES
@export var minimum_movespeed: int
@export var current_movespeed: int
@export var max_extra_jumps: int
@export var current_extra_jumps: int

# GAME STATS
@export var health: int
@export var max_health: int = 100
@export var gold_health: int
@export var max_gold_health: int = 100
@export var health_regen_modifier: float = 1

@export var max_mana_points: int
@export var max_mystic_points: int
@export var current_mana_points: int
@export var current_mystic_points: int
@export var mana_regen_modifier: float = 1

var active_left_arm: Arm
var inactive_left_arm: Arm
var active_right_arm: Arm
var inactive_right_arm: Arm

@export var strength: int = 0
@export var dexterity: int = 0
@export var force: int = 0
@export var technique: int = 0

@export var magic: int = 0
@export var light: int = 0
@export var dark: int = 0
@export var voyd: int = 0
