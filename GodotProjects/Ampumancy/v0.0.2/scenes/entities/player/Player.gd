extends CharacterBody2D
class_name Player

enum PRIMARY_STATES {IDLE, CAST, HIT, }
enum EFFECT_STATES {NONE, PSN, BRN, SHK, FRZ, LYT, VYD}

@onready var marker_dict: Dictionary = {
	-1.0: [
		$ArmMarkers/ArmsL/LArm1,
		$ArmMarkers/ArmsL/LArm2,
		$ArmMarkers/ArmsL/RArm1,
		$ArmMarkers/ArmsL/RArm2
	],
	1.0: [
		$ArmMarkers/ArmsR/LArm1,
		$ArmMarkers/ArmsR/LArm2,
		$ArmMarkers/ArmsR/RArm1,
		$ArmMarkers/ArmsR/RArm2]}

@onready var LArm1: Sprite2D = $Sprite/LArms/LArm1
@onready var LArm2: Sprite2D = $Sprite/LArms/LArm2
@onready var RArm1: Sprite2D = $Sprite/RArms/RArm1
@onready var RArm2: Sprite2D = $Sprite/RArms/RArm2

var ActiveLArm: Sprite2D
var ActiveRArm: Sprite2D

@onready var JUMP_VEL: float = ((-2.0 * DATA.STATS.JUMP_HEIGHT) / DATA.STATS.TIME_TO_PEAK)
@onready var JUMP_GRAV: float = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_PEAK, 2))
@onready var FALL_GRAV: float = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_FALL, 2))

@export var DATA: PlayerData

var look_dir: float = 1.0
var last_look: float = 1.0


func _ready() -> void:
	ActiveLArm = LArm1
	ActiveRArm = RArm1


func _process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	controls(delta, input_vector)
	update_look_dir()
	update_sprite()


@warning_ignore("unused_parameter")
func controls(delta: float, input_vector: Vector2) -> void:
	walk(input_vector)
	jump()
	
	if is_on_floor():
		DATA.STATS.DJUMPS = DATA.STATS.MAX_DJUMPS
	
	gravity(delta)
	move_and_slide()


func walk(input_vector: Vector2) -> void:
	if input_vector.x == 0:
		if is_on_floor():
			$AnimationHandlers/AnimationTree["parameters/conditions/walk"] = false
			$AnimationHandlers/AnimationTree["parameters/conditions/idle"] = true
			velocity.x = velocity.move_toward(Vector2.ZERO, DATA.STATS.DECEL).x
		else:
			velocity.x = velocity.move_toward(Vector2.ZERO, DATA.STATS.AIRDECEL).x
	else:
		if is_on_floor():
			$AnimationHandlers/AnimationTree["parameters/conditions/idle"] = false
			$AnimationHandlers/AnimationTree["parameters/conditions/walk"] = true
			velocity.x = velocity.move_toward(input_vector * DATA.STATS.MOVESPEED, DATA.STATS.ACCEL).x
		else:
			velocity.x = velocity.move_toward(input_vector * DATA.STATS.MOVESPEED, DATA.STATS.AIRACCEL).x


func jump() -> void:
	if Input.is_action_just_pressed("JUMP"):
		if is_on_floor():
			velocity.y = JUMP_VEL
		elif DATA.STATS.DJUMPS > 0:
			velocity.y = JUMP_VEL
			DATA.STATS.DJUMPS -= 1


func gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += JUMP_GRAV * delta
		else:
			velocity.y += FALL_GRAV * delta


func update_look_dir() -> void:
	if get_global_mouse_position().x < global_position.x:
		look_dir = -1.0
	elif get_global_mouse_position().x > global_position.x:
		look_dir = 1.0


func update_sprite() -> void:
	if last_look != look_dir:
		last_look = look_dir
		update_anims()
		update_arms()
		reorder_spritelets()


func reorder_spritelets() -> void:
	var index: int = -1
	for child in $Sprite.get_children().slice(3):
		if child is not Sprite2D:
			child.move_child(child.get_child(0), -1)
		$Sprite.move_child(child, index)
		index -= 1


func update_arms() -> void:
	var arms: Array[Sprite2D] = [LArm1, LArm2, RArm1, RArm2]
	for arm in arms:
		arm.position = marker_dict[look_dir][arms.find(arm)].position
		if arm.name != ActiveLArm.name and arm.name != ActiveRArm.name:
			arm.rotation = marker_dict[look_dir][arms.find(arm)].rotation
		else:
			arm.look_at(get_global_mouse_position())


func update_anims() -> void:
	# Updates the blend positions of all animations to reflect the direction the player is facing
	$AnimationHandlers/AnimationTree["parameters/Idle/blend_position"] = look_dir
	$AnimationHandlers/AnimationTree["parameters/Walk/blend_position"] = look_dir
