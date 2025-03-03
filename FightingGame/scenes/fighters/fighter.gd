extends CharacterBody2D
class_name Fighter

# MOVE HOLD TO SPRINT/WALK TO PLAYER SETTINGS

var hold_to_sprint: bool = true

var current_speed: int
@export var walk_speed: int
@export var run_speed: int
@export var ground_acceleration: int
@export var ground_friction: int

var current_extra_jumps: int
@export var max_extra_jumps: int

# JUMP CALCULATIONS
@onready var jump_velocity: float = ((-2.0 * jump_height) / seconds_to_peak)
@onready var jump_gravity:  float = ((2.0 * jump_height) / (seconds_to_peak * seconds_to_peak))
@onready var fall_gravity:  float = ((2.0 * jump_height) / (seconds_to_fall * seconds_to_fall))

# JUMP VARIABLES (CHANGE IN INSPECTOR)
@export var jump_height: float
@export var seconds_to_peak: float
@export var seconds_to_fall: float


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	fighter_controls()


func fighter_controls() -> void:
	
	if Input.is_action_pressed("SPRINT_MODIFIER"):
		if hold_to_sprint:
			current_speed = run_speed
		else:
			current_speed = walk_speed
	
	if Input.is_action_pressed("RIGHT"):
		velocity.x = velocity.move_toward(Vector2(1, 0) * current_speed, ground_acceleration).x
	if Input.is_action_pressed("LEFT"):
		velocity.x = velocity.move_toward(Vector2(-1, 0) * current_speed, ground_acceleration).x
	if not Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT"):
		velocity.x = velocity.move_toward(Vector2.ZERO * current_speed, ground_friction).x
	
	# JUMP CONTROLS
	if is_on_floor():
		current_extra_jumps = max_extra_jumps
	
	if Input.is_action_just_pressed("JUMP"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif current_extra_jumps > 0:
			velocity.y = jump_velocity
			current_extra_jumps -= 1
	
	if velocity.y > 0:
		velocity.y += fall_gravity
	elif velocity.y < 0:
		velocity.y += jump_gravity
	
	# END CONTROL ENGINE
	move_and_slide()
