@tool
extends CharacterBody2D
class_name Player

@export var stats: PlayerStats
@export var equipment: PlayerEquipment
@export var inventory: PlayerInventory
@export var outfit: PlayerOutfit
@export var move_data: MovementData
@export var cast_config: CastConfiguration


# TODO: Work on spellcasting
func _ready() -> void:
	if not Engine.is_editor_hint():
		Singletons.player = self
		SignalBus.PlayerSpawn.emit()
		
		if get_global_mouse_position().x < position.x:
			$Sprite.flip_sprite()
			move_data.look_direction = -1
			move_data.last_look_direction = -1
		elif get_global_mouse_position().x > position.x:
			move_data.look_direction = 1
			move_data.last_look_direction = 1


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process(delta)


func tool_process(delta: float) -> void:
	pass


func game_process(delta: float) -> void:
	movement(delta)
	casting()
	mouse()


func set_jump_variables() -> void:
	var jump_height: float
	if move_data.override_jump_height != 0:
		jump_height = move_data.override_jump_height
	else:
		jump_height = move_data.jump_height * (1 + move_data.jump_height_mod)
	move_data.jump_velocity = ((-2 * jump_height) / move_data.time_to_peak)
	move_data.jump_gravity = ((2 * jump_height) / (move_data.time_to_peak * move_data.time_to_peak))
	move_data.fall_gravity = ((2 * jump_height) / (move_data.time_to_land * move_data.time_to_land))


# TODO: Needs a way to iterate through each movement modulator and adjust them 
# depending on the effect tile the player is standing on.
func set_movement_modulators() -> void:
	if move_data.current_tile:
		pass


func mouse() -> void:
	if get_global_mouse_position().x < global_position.x:
		move_data.look_direction = -1
	elif get_global_mouse_position().x > global_position.x:
		move_data.look_direction = 1
	update_animation_blends()
	on_player_look_flip()
	$Sprite/LArms.active_arm.look_at(get_global_mouse_position())
	$Sprite/RArms.active_arm.look_at(get_global_mouse_position())


func on_player_look_flip() -> void:
	if move_data.look_direction != move_data.last_look_direction:
		move_data.last_look_direction = move_data.look_direction
		$Sprite.flip_sprite()


func casting() -> void:
	if not Input.is_action_pressed("LMB"):
		cast_config.LFocus = false
	if not Input.is_action_pressed("RMB"):
		cast_config.RFocus = false
		
	if Input.is_action_just_pressed("LMB"):
		cast_config.LFocus = true
		if not cast_config.LBusy:
			var active_arm: Sprite2D = $Sprite/LArms.active_arm
			if active_arm.name.ends_with("1"):
				spell_cast(equipment.LArm1)
				SignalBus.PlayerLCast.emit()
			else:
				spell_cast(equipment.LArm2)
				SignalBus.PlayerLCast.emit()
	if Input.is_action_just_pressed("RMB"):
		cast_config.RFocus = true
		if not cast_config.LBusy:
			var active_arm: Sprite2D = $Sprite/RArms.active_arm
			if active_arm.name.ends_with("1"):
				spell_cast(equipment.RArm1)
				SignalBus.PlayerRCast.emit()
			else:
				spell_cast(equipment.RArm2)
				SignalBus.PlayerRCast.emit()


func spell_cast(arm: ArmData) -> void:
	if stats.current_solar_nodes >= arm.solar_cost or arm.solar_cost == 0:
		if stats.current_mystic_nodes >= arm.mystic_cost or arm.mystic_cost == 0:
			if stats.current_mana_nodes >= arm.mana_cost or arm.mana_cost == 0:
				pass
			else:
				SignalBus.PlayerManaBurnout.emit()
		else:
			SignalBus.PlayerMysticBurnout.emit()
	else:
		SignalBus.PlayerSolarBurnout.emit()


func movement(delta: float) -> void:
	move_data.input_vector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	set_movement_modulators()
	set_jump_variables()
	
	# These controls dictate which air state the player is in.
	if is_on_floor():
		move_data.air_state = move_data.AirStates.GROUNDED
		move_data.current_double_jumps = move_data.max_double_jumps
	elif velocity.y > 0:
		move_data.air_state = move_data.AirStates.FALL
	
	# These controls dictate what ground state the player would be in if on the ground.
	if move_data.input_vector.x != 0:
		if Input.is_action_pressed("SPRINT"):
			move_data.ground_state = move_data.GroundStates.SPRINT
		else:
			move_data.ground_state = move_data.GroundStates.WALK
	else:
		move_data.ground_state = move_data.GroundStates.IDLE
	
	jump()
	acceleration(delta)
	update_animation_parameters()
	move_and_slide()


func jump() -> void:
	if move_data.air_state == move_data.AirStates.GROUNDED and Input.is_action_just_pressed("JUMP"):
		move_data.air_state = move_data.AirStates.JUMP
		velocity.y = move_data.jump_velocity
		SignalBus.PlayerJump.emit()
	elif move_data.temp_double_jumps > 0 and Input.is_action_just_pressed("JUMP"):
		move_data.air_state = move_data.AirStates.JUMP
		velocity.y = move_data.jump_velocity
		move_data.temp_double_jumps -= 1
		SignalBus.PlayerJump.emit()
	elif move_data.current_double_jumps > 0 and Input.is_action_just_pressed("JUMP"):
		move_data.air_state = move_data.AirStates.JUMP
		velocity.y = move_data.jump_velocity
		move_data.current_double_jumps -= 1
		SignalBus.PlayerJump.emit()


func acceleration(delta: float) -> void:
	var vel: float
	var accel: float
	
	if move_data.ground_state == move_data.GroundStates.IDLE:
		vel = 0
		if move_data.air_state == move_data.AirStates.GROUNDED:
			accel = move_data.decel
		else:
			accel = move_data.air_decel
	elif move_data.ground_state == move_data.GroundStates.WALK:
		if move_data.air_state == move_data.AirStates.GROUNDED:
			vel = move_data.movespeed
			accel = move_data.accel
		else:
			vel = move_data.air_movespeed
			accel = move_data.air_accel
	elif move_data.ground_state == move_data.GroundStates.SPRINT:
		vel = move_data.sprintspeed
		accel = move_data.accel
	
	velocity.x = velocity.move_toward(Vector2(move_data.input_vector.x * vel, 0.0), accel).x
	gravity(delta)


func gravity(delta: float) -> void:
	if velocity.y < 0:
		velocity.y += move_data.jump_gravity * delta
	else:
		velocity.y += move_data.fall_gravity * delta


func update_animation_parameters() -> void:
	if move_data.air_state == move_data.AirStates.GROUNDED:
		if move_data.ground_state == move_data.GroundStates.IDLE:
			set_animation_parameters("idle")
		elif move_data.ground_state == move_data.GroundStates.WALK:
			set_animation_parameters("walk")
		elif move_data.ground_state == move_data.GroundStates.SPRINT:
			set_animation_parameters("sprint")
	elif move_data.air_state == move_data.AirStates.JUMP:
		set_animation_parameters("jump")
	elif move_data.air_state == move_data.AirStates.FALL:
		set_animation_parameters("fall")


func set_animation_parameters(true_param: String) -> void:
	var params: Array[String] = ["idle", "walk", "sprint", "jump", "fall"]
	for param in params:
		$AnimationTree["parameters/conditions/" + param] = false
		if param == true_param:
			$AnimationTree["parameters/conditions/" + param] = true


func update_animation_blends() -> void:
	$AnimationTree["parameters/Idle/blend_position"] = move_data.look_direction
	$AnimationTree["parameters/Walk/blend_position"] = move_data.look_direction
	$AnimationTree["parameters/Sprint/blend_position"] = move_data.look_direction
	$AnimationTree["parameters/Jump/blend_position"] = move_data.look_direction
	$AnimationTree["parameters/Fall/blend_position"] = move_data.look_direction
