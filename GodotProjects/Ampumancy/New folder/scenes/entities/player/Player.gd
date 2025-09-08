extends CharacterBody2D
class_name Player

signal spell_cast(spell: Node2D)

enum PRIMARY_STATES {IDLE, CAST, HIT, }
enum EFFECT_STATES {NONE, PSN, BRN, SHK, FRZ, LYT, VYD}

@onready var JUMP_VEL: float
@onready var JUMP_GRAV: float
@onready var FALL_GRAV: float
var GRAV_MOD: float = 1.0

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

var DATA: PlayerData
var TILE: TileData

var look_dir: float = 1.0
var last_look: float = 1.0

var boost_tween: Tween

var Arms: Array[Sprite2D]
var ActiveLArm: Sprite2D
var ActiveRArm: Sprite2D
var LArmBusy: bool = false
var RArmBusy: bool = false

var mana_regen_timer_started: bool = false
var health_regen_timer_started: bool = false
var jump_timed_out: bool = false



func _ready() -> void:
	AutoSave.start()
	name = "Player"
	Globals.PLAYER = self
	DATA = Globals.SAVE.PLAYER
	Globals.PLAY_START = Time.get_ticks_msec()
	global_position = Globals.SAVE.CURRENT_POS
	
	# SET JUMP AND GRAVITY VALUES
	JUMP_VEL = ((-2.0 * DATA.STATS.JUMP_HEIGHT) / DATA.STATS.TIME_TO_PEAK)
	JUMP_GRAV = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_PEAK, 2))
	FALL_GRAV = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_FALL, 2))
	
	# PREPARE ARMS FOR PROCESS
	ActiveLArm = LArm1
	ActiveRArm = RArm1
	DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm1.Arm
	DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm1.Arm
	Arms = [LArm1, LArm2, RArm1, RArm2]
	
	update_arm_sprites()
	update_outfit()
	SignalBus.player_ready.emit()


func _process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	TILE = Globals.MAIN.current_tile
	update_sprite()
	update_camera()
	update_cumulatives()
	controls(delta, input_vector)


func update_camera() -> void:
	camera_mouse_follow()
	update_camera_limits()
	#zoom()


func camera_mouse_follow() -> void:
	var mouse_offset: Vector2 = get_viewport().get_mouse_position() - Vector2(get_viewport().size) / 2
	$PlayerCam.position = lerp(Vector2(0, -200), mouse_offset.normalized() * 250, mouse_offset.length() / 1000)


func update_camera_limits() -> void:
	$PlayerCam.limit_left = global_position.x - (1200 / $PlayerCam.zoom.x)
	$PlayerCam.limit_right = global_position.x + (1200 / $PlayerCam.zoom.x)
	$PlayerCam.limit_bottom = global_position.y + 720


func controls(delta: float, input_vector: Vector2) -> void:
	jump()
	on_cast_pressed()
	on_landing()
	regen_timers()
	update_look_dir()
	walk(input_vector)
	switch_active_arms()
	camera_mouse_follow()
	
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
			if TILE:
				velocity.x = velocity.move_toward(input_vector * DATA.STATS.MOVESPEED * (TILE.get_custom_data("speed_mod") + 1), DATA.STATS.ACCEL).x
				$AnimationHandlers/AnimationPlayer.speed_scale *= TILE.get_custom_data("speed_mod") + 1
			else:
				velocity.x = velocity.move_toward(input_vector * DATA.STATS.MOVESPEED, DATA.STATS.ACCEL).x
		else:
			velocity.x = velocity.move_toward(input_vector * DATA.STATS.AIRMOVESPEED, DATA.STATS.AIRACCEL).x


func jump() -> void:
	$Timers/JumpBoostStart.wait_time = DATA.STATS.TIME_TO_PEAK
	var MOD_JUMP: float = JUMP_VEL / GRAV_MOD
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		if TILE:
			velocity.y = MOD_JUMP * (TILE.get_custom_data("jump_mod") + 1)
		else:
			velocity.y = MOD_JUMP
		$Timers/JumpBoostStart.start()
	boost()


func boost() -> void:
	var bool_array: Array[bool] = boost_controls()
	if not is_on_floor() and DATA.STATS.JUMP_BOOST > 0 and jump_timed_out:
		if bool_array[0] or bool_array[1]:
			$AnimationHandlers/AnimationTree["parameters/conditions/boost"] = true
			$AnimationHandlers/AnimationTree["parameters/conditions/idle"] = false
			$AnimationHandlers/AnimationTree["parameters/conditions/walk"] = false
			$ParticleHandlers/BoostTrailParticles.emitting = true
			if bool_array[0]:
				velocity.y = DATA.STATS.BOOST_VEL / GRAV_MOD
			elif bool_array[1]:
				velocity.y = DATA.STATS.HOVER_VEL
			if $Timers/JumpBoostConsume.is_stopped():
				DATA.STATS.JUMP_BOOST -= 5
				$Timers/JumpBoostConsume.start()
	if not bool_array[0] and not bool_array[1] or is_on_floor() or not DATA.STATS.JUMP_BOOST > 0 or not jump_timed_out:
		$AnimationHandlers/AnimationTree["parameters/conditions/boost"] = false
		$ParticleHandlers/BoostTrailParticles.emitting = false
		$Timers/JumpBoostConsume.stop()


func boost_dash() -> void:
	pass


func boost_controls() -> Array[bool]:
	var bool_array: Array[bool] = [false, false]
	if Input.is_action_pressed("UP"):
		bool_array[1] = true
	if Input.is_action_pressed("JUMP"):
		bool_array[0] = true
		bool_array[1] = false
	return bool_array


func regen_boost(value: int) -> void:
	DATA.STATS.JUMP_BOOST = clampi(DATA.STATS.JUMP_BOOST + value, 0, DATA.STATS.MAX_JUMP_BOOST)


func on_landing() -> void:
	if is_on_floor():
		Globals.SAVE.CURRENT_POS = global_position
		jump_timed_out = false
		if DATA.STATS.JUMP_BOOST < DATA.STATS.MAX_JUMP_BOOST:
			if $Timers/JumpBoostRegen.is_stopped():
				$Timers/JumpBoostRegen.start()
	else:
		$Timers/JumpBoostRegen.stop()
		if boost_tween:
			boost_tween.stop()


func zoom() -> void:
	if Input.is_action_just_pressed("ZOOM+") and $PlayerCam.zoom.x < Globals.MAX_ZOOM:
		get_tree().create_tween().tween_property($PlayerCam, "zoom", $PlayerCam.zoom + Vector2(0.2, 0.2), 0.2)
	if Input.is_action_just_pressed("ZOOM-") and $PlayerCam.zoom.x > Globals.MIN_ZOOM:
		get_tree().create_tween().tween_property($PlayerCam, "zoom", $PlayerCam.zoom - Vector2(0.2, 0.2), 0.2)
	if Input.is_action_just_pressed("ZOOMR"):
		get_tree().create_tween().tween_property($PlayerCam, "zoom", Vector2(1.0, 1.0), 0.2)
	$PlayerCam.zoom = clamp($PlayerCam.zoom, Vector2(Globals.MIN_ZOOM, Globals.MIN_ZOOM), Vector2(Globals.MAX_ZOOM, Globals.MAX_ZOOM))


func on_cast_pressed() -> void:
	if Input.is_action_just_pressed("CASTL") and DATA.EQUIPMENT.ActiveLArm.spell_id != 0:
		cast_spell(ActiveLArm, DATA.EQUIPMENT.ActiveLArm, LArmBusy)
	if Input.is_action_just_pressed("CASTR") and DATA.EQUIPMENT.ActiveRArm.spell_id != 0:
		cast_spell(ActiveRArm, DATA.EQUIPMENT.ActiveRArm, RArmBusy)


func cast_spell(arm: Sprite2D, arm_data: ArmData, busy: bool) -> void:
	if not busy:
		if consume_mana(arm_data.mana_cost):
			if arm.name.begins_with("L"):
				LArmBusy = true
			elif arm.name.begins_with("R"):
				RArmBusy = true
			var spell: Spell = SpellLib.cast_spell(arm_data.spell_id).instantiate()
			spell.ORIGIN = arm.get_child(0)
			spell.TEAM = Util.TEAMS.PLAYER
			spell_cast.emit(spell)
		else:
			pass # DO ON FAIL LOGIC


func update_cumulatives() -> void:
	DATA.STATS.CUMULATIVE_HEALTH = DATA.STATS.HEALTH + DATA.STATS.GOLD_HEALTH
	DATA.STATS.CUMULATIVE_MAX_HEALTH = DATA.STATS.MAX_HEALTH + DATA.STATS.MAX_GOLD_HEALTH
	DATA.STATS.CUMULATIVE_MANA = DATA.STATS.MANA + DATA.STATS.MYSTIC + DATA.STATS.SOLAR
	DATA.STATS.CUMULATIVE_MAX_MANA = DATA.STATS.MAX_MANA + DATA.STATS.MAX_MYSTIC + DATA.STATS.SOLAR_LIMIT


func regen_timers() -> void:
	if DATA.STATS.CUMULATIVE_HEALTH < DATA.STATS.CUMULATIVE_MAX_HEALTH and not health_regen_timer_started:
		$Timers/HealthRegen.start()
		health_regen_timer_started = true
	if DATA.STATS.CUMULATIVE_MANA < DATA.STATS.CUMULATIVE_MAX_MANA and not mana_regen_timer_started:
		$Timers/ManaRegen.start()
		mana_regen_timer_started = true


func regen_mana(value: int) -> void:
	while value > 0:
		if DATA.STATS.MANA + value <= DATA.STATS.MAX_MANA:
			DATA.STATS.MANA += value
			value = 0
		elif DATA.STATS.MANA < DATA.STATS.MAX_MANA:
			value -= DATA.STATS.MAX_MANA - DATA.STATS.MANA
			DATA.STATS.MANA = DATA.STATS.MAX_MANA
		else:
			if DATA.STATS.MYSTIC + value <= DATA.STATS.MAX_MYSTIC:
				DATA.STATS.MYSTIC += value
				value = 0
			elif DATA.STATS.MYSTIC < DATA.STATS.MAX_MYSTIC:
				value -= DATA.STATS.MAX_MYSTIC - DATA.STATS.MYSTIC
				DATA.STATS.MYSTIC = DATA.STATS.MAX_MYSTIC
			else:
				value = 0


func regen_solar(value: int) -> void:
	while value > 0:
		if DATA.STATS.SOLAR + value <= DATA.STATS.SOLAR_LIMIT:
			DATA.STATS.SOLAR += value
			value = 0
		elif DATA.STATS.SOLAR < DATA.STATS.SOLAR_LIMIT:
			value -= DATA.STATS.SOLAR_LIMIT - DATA.STATS.SOLAR
			DATA.STATS.SOLAR = DATA.STATS.SOLAR_LIMIT
		else:
			value = 0


# This function both tests for whether the player has enough
# mana to cast the chosen spell, and consumes the mana if so.
func consume_mana(value: int) -> bool:
	while value > 0:
		if DATA.STATS.SOLAR >= value:
			DATA.STATS.SOLAR -= value
			value = 0
		elif DATA.STATS.SOLAR > 0:
			value -= DATA.STATS.SOLAR
			DATA.STATS.SOLAR = 0
		else:
			if DATA.STATS.MYSTIC >= value:
				DATA.STATS.MYSTIC -= value
				value = 0
			elif DATA.STATS.MYSTIC > 0:
				value -= DATA.STATS.MYSTIC
				DATA.STATS.MYSTIC = 0
			else:
				if DATA.STATS.MANA >= value:
					DATA.STATS.MANA -= value
					value = 0
				else:
					return false
	$Timers/ManaRegen.start()
	return true


func switch_active_arms() -> void:
	if Input.is_action_just_pressed("SWITCHL"):
		switch_active_larm()
	if Input.is_action_just_pressed("SWITCHR"):
		switch_active_rarm()


func switch_active_larm() -> void:
	for arm in Arms.slice(0, 2):
		arm.rotation = marker_dict[look_dir][Arms.find(arm)].rotation
	if ActiveLArm.name.ends_with("1"):
		ActiveLArm = LArm2
		DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm2.Arm
	else:
		ActiveLArm = LArm1
		DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm1.Arm


func switch_active_rarm() -> void:
	for arm in Arms.slice(2):
		arm.rotation = marker_dict[look_dir][Arms.find(arm)].rotation
	if ActiveRArm.name.ends_with("1"):
		ActiveRArm = RArm2
		DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm2.Arm
	else:
		ActiveRArm = RArm1
		DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm1.Arm


func gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += JUMP_GRAV * GRAV_MOD * delta
		else:
			velocity.y += FALL_GRAV * GRAV_MOD * delta
	if GRAV_MOD < 0:
		for child in $Sprite.get_children():
			if child is Sprite2D:
				child.flip_v = true
			else:
				for arm in child.get_children():
					pass


func update_look_dir() -> void:
	# Updates the player's look direction to reflect where the mouse is on the screen
	if get_global_mouse_position().x < global_position.x:
		look_dir = -1.0
	elif get_global_mouse_position().x > global_position.x:
		look_dir = 1.0


func update_sprite() -> void:
	# This code executes every process loop, regardless of
	# whether or not the current look direction has changed
	rotate_active_arms()
	update_arms()
	# Only executes sprite update code if the current look
	# direction has changed since the last process loop
	if last_look != look_dir:
		last_look = look_dir
		update_anims()
		reorder_spritelets()


func reorder_spritelets() -> void:
	# Reorders spritelets to maintain proper draw order in the $Sprite
	# canvas group when the player switches look directions
	var index: int = -1
	for child in $Sprite.get_children().slice(3):
		if child is not Sprite2D:
			child.move_child(child.get_child(0), -1)
		$Sprite.move_child(child, index)
		index -= 1


func rotate_active_arms() -> void:
	for arm in Arms:
		if arm.name == ActiveLArm.name or arm.name == ActiveRArm.name:
			arm.look_at(get_global_mouse_position())


func update_outfit() -> void:
	$Sprite/Hat.texture = DATA.Hat
	$Sprite/Head.texture = DATA.Head
	$Sprite/Eyes.texture = DATA.Eyes
	$Sprite/LCloak.texture = DATA.Cloak
	$Sprite/RCloak.texture = DATA.Cloak
	$Sprite/Body.texture = DATA.Body


func update_arms() -> void:
	# Updates all arms' positions + rotations (excluding active
	# arms' rotations) to reflect the current look direction
	for arm in Arms:
		arm.position = marker_dict[look_dir][Arms.find(arm)].position
		var vert_dir: float
		if GRAV_MOD < 0:
			vert_dir = -1.0
		else:
			vert_dir = 1.0
		if arm.name != ActiveLArm.name and arm.name != ActiveRArm.name:
			arm.rotation = marker_dict[look_dir][Arms.find(arm)].rotation * vert_dir


func update_arm_sprites() -> void:
	LArm1.texture = DATA.EQUIPMENT.LArm1.Arm.texture
	LArm2.texture = DATA.EQUIPMENT.LArm2.Arm.texture
	RArm1.texture = DATA.EQUIPMENT.RArm1.Arm.texture
	RArm2.texture = DATA.EQUIPMENT.RArm2.Arm.texture


func update_anims() -> void:
	# Updates the blend positions of all animations to reflect the current look direction
	$AnimationHandlers/AnimationTree["parameters/Idle/blend_position"] = look_dir
	$AnimationHandlers/AnimationTree["parameters/Walk/blend_position"] = look_dir
	$AnimationHandlers/AnimationTree["parameters/Boost/blend_position"] = look_dir


func heal(value: int) -> void:
	while value > 0:
		if DATA.STATS.CUMULATIVE_HEALTH < DATA.STATS.CUMULATIVE_MAX_HEALTH:
			if DATA.STATS.HEALTH + value <= DATA.STATS.MAX_HEALTH:
				get_tree().create_tween().tween_property(DATA.STATS, "HEALTH", DATA.STATS.HEALTH + value, 0.2)
				value = 0
			else:
				value -= DATA.STATS.MAX_HEALTH - DATA.STATS.HEALTH
				get_tree().create_tween().tween_property(DATA.STATS, "HEALTH", DATA.STATS.MAX_HEALTH, 0.2)
				if DATA.STATS.GOLD_HEALTH + value <= DATA.STATS.MAX_GOLD_HEALTH:
					get_tree().create_tween().tween_property(DATA.STATS, "GOLD_HEALTH", DATA.STATS.GOLD_HEALTH + value, 0.2)
					value = 0
				else:
					value -= DATA.STATS.MAX_GOLD_HEALTH - DATA.STATS.GOLD_HEALTH
					get_tree().create_tween().tween_property(DATA.STATS, "GOLD_HEALTH", DATA.STATS.MAX_GOLD_HEALTH, 0.2)
		else:
			value = 0


func damage(_value: int) -> void:
	pass


func _on_mana_regen_timeout() -> void:
	regen_mana(1)
	mana_regen_timer_started = false


func _on_health_regen_timeout() -> void:
	heal(5)
	health_regen_timer_started = false


func _on_jump_boost_regen_timeout() -> void:
	pass
	#boost_tween = get_tree().create_tween()
	#boost_tween.tween_property(DATA.STATS, "JUMP_BOOST", DATA.STATS.MAX_JUMP_BOOST, 1.5)


func _on_jump_boost_consume_timeout() -> void:
	DATA.STATS.JUMP_BOOST -= 5


func _on_jump_boost_start_timeout() -> void:
	jump_timed_out = true
