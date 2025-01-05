extends Controllable
class_name Player

# JUMP CALCULATIONS
var jump_velocity: float = -1 * ((2.0 * jump_height) / time_to_peak)
var jump_gravity: float = -1 * ((-2.0 * jump_height) / (time_to_peak * time_to_peak))
var fall_gravity: float = -1 * ((-2.0 * jump_height) / (time_to_fall * time_to_fall))

@export var jump_height: float
@export var time_to_peak: float
@export var time_to_fall: float


@export var stats: Stats


func _process(_delta: float) -> void:
	velocity.y = get_grav()
	
	if Input.is_action_pressed("left"):
		velocity.x = -1 * stats.movespeed
	if Input.is_action_pressed("right"):
		velocity.x = stats.movespeed
	
	if Input.is_action_pressed("jump") and is_on_floor():
		jump()
	
	move_and_slide()


func jump():
	velocity.y = jump_velocity


func get_grav() -> float:
	if velocity.y < 0:
		return jump_gravity
	else:
		return fall_gravity
