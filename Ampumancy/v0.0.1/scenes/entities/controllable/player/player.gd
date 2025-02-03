extends Controllable
class_name Player

var xcoord: int
var ycoord: int

# JUMP CALCULATIONS
@onready var jump_velocity: float = -1 * ((2.0 * jump_height) / time_to_peak)
@onready var jump_gravity: float = -1 * ((-2.0 * jump_height) / (time_to_peak * time_to_peak))
@onready var fall_gravity: float = -1 * ((-2.0 * jump_height) / (time_to_fall * time_to_fall))

@export var jump_height: float
@export var time_to_peak: float
@export var time_to_fall: float

@export var stats: Stats


func _process(delta: float) -> void:
	# IN-GAME COORDINATES
	xcoord = position.x / 40
	ycoord = (position.y + 65) / 40
	
	# GRAVITY
	velocity.y += get_grav() * delta
	
	# MOVEMENT
	if Input.is_action_pressed("left"):
		velocity.x = -1 * stats.movespeed
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x = stats.movespeed
		$Sprite2D.flip_h = false
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		velocity.x = 0
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
