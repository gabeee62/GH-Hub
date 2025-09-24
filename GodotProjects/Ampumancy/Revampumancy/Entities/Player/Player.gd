@tool
extends CharacterBody2D
class_name Player

@export var stats: PlayerStats
@export var equipment: PlayerEquipment
@export var inventory: PlayerInventory
@export var outfit: PlayerOutfit
@export var movedata: MovementData


# TODO: Work on spellcasting
func _ready() -> void:
	if not Engine.is_editor_hint():
		Singletons.player = self
		set_jump_constants()
		
		if get_global_mouse_position().x < position.x:
			$Sprite.flip_sprite()
			movedata.look_direction = -1
			movedata.last_look_direction = -1
		elif get_global_mouse_position().x > position.x:
			movedata.look_direction = 1
			movedata.last_look_direction = 1


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
	movedata.jump_velocity = ((-2 * movedata.jump_height) / movedata.time_to_peak)
	movedata.jump_gravity = ((2 * movedata.jump_height) / (movedata.time_to_peak * movedata.time_to_peak))
	movedata.fall_gravity = ((2 * movedata.jump_height) / (movedata.time_to_land * movedata.time_to_land))


func mouse() -> void:
	if get_global_mouse_position().x < global_position.x:
		movedata.look_direction = -1
	elif get_global_mouse_position().x > global_position.x:
		movedata.look_direction = 1
	update_animation_blends()
	on_player_look_flip()
	$Sprite/LArms.active_arm.look_at(get_global_mouse_position())
	$Sprite/RArms.active_arm.look_at(get_global_mouse_position())


func on_player_look_flip() -> void:
	if movedata.look_direction != movedata.last_look_direction:
		movedata.last_look_direction = movedata.look_direction
		$Sprite.flip_sprite()


func movement(delta: float) -> void:
	movedata.input_vector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	if is_on_floor():
		movedata.air_state = movedata.AirStates.GROUNDED
		movedata.current_double_jumps = movedata.max_double_jumps
	elif velocity.y > 0:
		movedata.air_state = movedata.AirStates.FALL
	
	if movedata.input_vector.x != 0:
		if Input.is_action_pressed("SPRINT"):
			movedata.ground_state = movedata.GroundStates.SPRINT
		else:
			movedata.ground_state = movedata.GroundStates.WALK
	else:
		movedata.ground_state = movedata.GroundStates.IDLE
	
	jump()
	acceleration(delta)
	update_animation_parameters()
	move_and_slide()


func jump() -> void:
	if movedata.air_state == movedata.AirStates.GROUNDED and Input.is_action_just_pressed("JUMP"):
		movedata.air_state = movedata.AirStates.JUMP
		velocity.y = movedata.jump_velocity
	elif movedata.current_double_jumps > 0 and Input.is_action_just_pressed("JUMP"):
		movedata.air_state = movedata.AirStates.JUMP
		velocity.y = movedata.jump_velocity
		movedata.current_double_jumps -= 1


func acceleration(delta: float) -> void:
	var vel: float
	var accel: float
	
	if movedata.ground_state == movedata.GroundStates.IDLE:
		vel = 0
		if movedata.air_state == movedata.AirStates.GROUNDED:
			accel = movedata.decel
		else:
			accel = movedata.air_decel
	elif movedata.ground_state == movedata.GroundStates.WALK:
		if movedata.air_state == movedata.AirStates.GROUNDED:
			vel = movedata.movespeed
			accel = movedata.accel
		else:
			vel = movedata.air_movespeed
			accel = movedata.air_accel
	elif movedata.ground_state == movedata.GroundStates.SPRINT:
		vel = movedata.sprintspeed
		accel = movedata.accel
	
	velocity.x = velocity.move_toward(Vector2(movedata.input_vector.x * vel, 0.0), accel).x
	gravity(delta)


func gravity(delta: float) -> void:
	if velocity.y < 0:
		velocity.y += movedata.jump_gravity * delta
	else:
		velocity.y += movedata.fall_gravity * delta


func update_animation_parameters() -> void:
	if movedata.air_state == movedata.AirStates.GROUNDED:
		if movedata.ground_state == movedata.GroundStates.IDLE:
			set_animation_parameters("idle")
		elif movedata.ground_state == movedata.GroundStates.WALK:
			set_animation_parameters("walk")
		elif movedata.ground_state == movedata.GroundStates.SPRINT:
			set_animation_parameters("sprint")
	elif movedata.air_state == movedata.AirStates.JUMP:
		set_animation_parameters("jump")
	elif movedata.air_state == movedata.AirStates.FALL:
		set_animation_parameters("fall")


func set_animation_parameters(true_param: String) -> void:
	var params: Array[String] = ["idle", "walk", "sprint", "jump", "fall"]
	for param in params:
		$AnimationTree["parameters/conditions/" + param] = false
		if param == true_param:
			$AnimationTree["parameters/conditions/" + param] = true


func update_animation_blends() -> void:
	$AnimationTree["parameters/Idle/blend_position"] = movedata.last_look_direction
	$AnimationTree["parameters/Walk/blend_position"] = movedata.last_look_direction
	$AnimationTree["parameters/Sprint/blend_position"] = movedata.last_look_direction
	$AnimationTree["parameters/Jump/blend_position"] = movedata.last_look_direction
	$AnimationTree["parameters/Fall/blend_position"] = movedata.last_look_direction
