extends CharacterBody2D
class_name Player

# ADD FLIP H ON MOUSE MOVEMENT
# ADD ARMS

signal spell(spell: Node2D)

var godmode: bool = false

var last_direction: int = 1

# SPELLS
var fireball_scene: PackedScene = preload("res://scenes/spells/fireball.tscn")

# GAME COORDINATES
var xcoord: int
var ycoord: int

# JUMP CALCULATIONS
@onready var jump_velocity: float = ((-2.0 * jump_height) / seconds_to_peak)
@onready var jump_gravity:  float = ((2.0 * jump_height) / (seconds_to_peak * seconds_to_peak))
@onready var fall_gravity:  float = ((2.0 * jump_height) / (seconds_to_fall * seconds_to_fall))

# JUMP VARIABLES (CHANGE IN INSPECTOR)
@export var jump_height: float
@export var seconds_to_peak: float
@export var seconds_to_fall: float

@export var stats: Stats


func _process(delta: float) -> void:
	# IN-GAME COORDINATES
	xcoord = position.x / 40
	ycoord = (position.y + 65) / -40
	
	# GRAVITY
	velocity.y += get_grav() * delta
	
	# GOD MODE (REMOVE BEFORE RELEASE)
	if Input.is_action_just_pressed("god_toggle"):
		godmode = not godmode
		
	# BASIC SPELL FUNCTIONALITY
	if Input.is_action_just_pressed("primary"):
		var fireball: Area2D = fireball_scene.instantiate()
		fireball.direction = last_direction
		fireball.position = $SpellEmission.global_position
		spell.emit(fireball)
		
	
	movement()


func movement() -> void:
	# WALK LEFT
	if Input.is_action_pressed("left"):
		velocity.x = -1 * stats.movespeed
		last_direction = -1
		for i in $Sprite.get_children():
			i.flip_h = true
		if is_on_floor():
			$AnimationPlayer.play("walk_l")
		else:
			$AnimationPlayer.play("walk_l")
	# WALK RIGHT
	if Input.is_action_pressed("right"):
		velocity.x = stats.movespeed
		last_direction = 1
		for i in $Sprite.get_children():
			i.flip_h = false
		if is_on_floor():
			$AnimationPlayer.play("walk_r")
		else:
			$AnimationPlayer.play("walk_r")
	# STOP AND IDLE
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		velocity.x = 0
		if last_direction == 1:
			$AnimationPlayer.play("idle_r")
		else:
			$AnimationPlayer.play("idle_l")
	# JUMP
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			stats.current_extra_jumps = stats.max_extra_jumps
			jump()
		elif stats.current_extra_jumps > 0:
			jump()
			stats.current_extra_jumps -= 1
	# GODMODE
	if godmode:
		if Input.is_action_pressed("up"):
			velocity.y = -stats.movespeed
		if Input.is_action_pressed("down"):
			velocity.y = stats.movespeed
		if not Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
			velocity.y = 0
	
	move_and_slide()


func jump() -> void:
	velocity.y = jump_velocity


func get_grav() -> float:
	if not godmode:
		if velocity.y < 0:
			return jump_gravity
		else:
			return fall_gravity
	else:
		return 0
