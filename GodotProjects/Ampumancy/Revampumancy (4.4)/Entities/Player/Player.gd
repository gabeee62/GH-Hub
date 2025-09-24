@tool
extends CharacterBody2D
class_name Player

@export var stats: PlayerStats
@export var equipment: PlayerEquipment
@export var inventory: PlayerInventory
@export var movement_data: MovementData

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

var input_vector: Vector2
var look_direction: int
var last_look_direction: int


func _ready() -> void:
	Singletons.player = self
	set_jump_constants()


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process(delta)


func tool_process(delta: float) -> void:
	pass


func game_process(delta: float) -> void:
	movement(delta)
	mouse()


func set_jump_constants() -> void:
	jump_velocity = ((-2 * movement_data.jump_height) / movement_data.time_to_peak)
	jump_gravity = ((2 * movement_data.jump_height) / (movement_data.time_to_peak * movement_data.time_to_peak))
	fall_gravity = ((2 * movement_data.jump_height) / (movement_data.time_to_land * movement_data.time_to_land))


func mouse() -> void:
	if get_global_mouse_position().x < global_position.x:
		look_direction = -1
	elif get_global_mouse_position().x > global_position.x:
		look_direction = 1
	update_animation_blends()
	on_player_look_flip()
	$Sprite/LArms.active_arm.look_at(get_global_mouse_position())
	$Sprite/RArms.active_arm.look_at(get_global_mouse_position())


func on_player_look_flip() -> void:
	if look_direction != last_look_direction:
		last_look_direction = look_direction
		$Sprite.flip_sprite()


func movement(delta: float) -> void:
	input_vector = Input.get_vector("UP", "DOWN", "LEFT", "RIGHT")
	
	if is_on_floor():
		movement_data.current_double_jumps = movement_data.max_double_jumps
		
		if input_vector.x != 0:
			if Input.is_action_pressed("SPRINT"):
				sprint()
			else:
				walk()
		else:
			idle()
		
		


func update_animation_parameters(true_param: String) -> void:
	var parameters: Array[String] = ["Idle", "Walk", "Sprint", "Jump"]
	for param in parameters:
		$AnimationTree["parameters/conditions/" + param] = false
		if param == true_param:
			$AnimationTree["parameters/conditions/" + param] = true


func update_animation_blends() -> void:
	$AnimationTree["parameters/Idle/blend_position"] = last_look_direction
	$AnimationTree["parameters/Walk/blend_position"] = last_look_direction
	$AnimationTree["parameters/Sprint/blend_position"] = last_look_direction
	$AnimationTree["parameters/Jump/blend_position"] = last_look_direction


func idle() -> void:
	update_animation_parameters("Idle")


func walk() -> void:
	update_animation_parameters("Walk")


func sprint() -> void:
	update_animation_parameters("Sprint")


func jump() -> void:
	if is_on_floor():
		update_animation_parameters("Jump")
		velocity.y = jump_velocity
	elif movement_data.current_double_jumps > 0:
		update_animation_parameters("Jump")
		velocity.y = jump_velocity
