extends CharacterBody2D
class_name Player

signal spell_cast(spell: Spell)

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
var Arms: Array[Sprite2D]

var ActiveLArm: Sprite2D
var ActiveRArm: Sprite2D

@onready var JUMP_VEL: float
@onready var JUMP_GRAV: float
@onready var FALL_GRAV: float

var look_dir: float = 1.0
var last_look: float = 1.0

var DATA: PlayerData


func _ready() -> void:
	name = "Player"
	Globals.PLAYER = self
	DATA = Globals.SAVE.PLAYER
	global_position = Globals.SAVE.CURRENT_POS
	
	# SET JUMP AND GRAVITY VALUES
	JUMP_VEL = ((-2.0 * DATA.STATS.JUMP_HEIGHT) / DATA.STATS.TIME_TO_PEAK)
	JUMP_GRAV = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_PEAK, 2))
	FALL_GRAV = ((2.0 * DATA.STATS.JUMP_HEIGHT) / Util.power_of(DATA.STATS.TIME_TO_FALL, 2))
	
	# PREPARE ARMS FOR PROCESS
	ActiveLArm = LArm1
	ActiveRArm = RArm1
	DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm1
	DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm1
	Arms = [LArm1, LArm2, RArm1, RArm2]
	
	update_arm_sprites()
	update_outfit()


func _process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	controls(delta, input_vector)
	update_look_dir()
	update_sprite()


func controls(delta: float, input_vector: Vector2) -> void:
	zoom()
	walk(input_vector)
	# cast_spell() -- WIP
	switch_active_arms()
	jump()
	
	if is_on_floor():
		Globals.SAVE.CURRENT_POS = global_position
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


func zoom() -> void:
	if Input.is_action_just_pressed("ZOOM+") and $PlayerCam.zoom.x < Globals.MAX_ZOOM:
		$PlayerCam.zoom += Vector2(.1, .1)
	if Input.is_action_just_pressed("ZOOM-") and $PlayerCam.zoom.x > Globals.MIN_ZOOM:
		$PlayerCam.zoom -= Vector2(.1, .1)


func cast_spell() -> void:
	if Input.is_action_just_pressed("CASTL") and DATA.EQUIPMENT.ActiveLArm.spell != SpellLib.SPELL_IDS.NONE:
		var spell: Spell = SpellLib.cast_spell(DATA.EQUIPMENT.ActiveLArm.spell).instantiate()
		spell.position = ActiveLArm.get_child(0).position
		spell_cast.emit(spell)
	if Input.is_action_just_pressed("CASTR") and DATA.EQUIPMENT.ActiveRArm.spell != SpellLib.SPELL_IDS.NONE:
		var spell: Spell = SpellLib.cast_spell(DATA.EQUIPMENT.ActiveRArm.spell).instantiate()
		spell.position = ActiveRArm.get_child(0).position
		spell_cast.emit(spell)


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
		DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm2
	else:
		ActiveLArm = LArm1
		DATA.EQUIPMENT.ActiveLArm = DATA.EQUIPMENT.LArm1


func switch_active_rarm() -> void:
	for arm in Arms.slice(2):
		arm.rotation = marker_dict[look_dir][Arms.find(arm)].rotation
	if ActiveRArm.name.ends_with("1"):
		ActiveRArm = RArm2
		DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm2
	else:
		ActiveRArm = RArm1
		DATA.EQUIPMENT.ActiveRArm = DATA.EQUIPMENT.RArm1


func gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += JUMP_GRAV * delta
		else:
			velocity.y += FALL_GRAV * delta


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
	# Only executes sprite update code if the current look
	# direction has changed since the last process loop
	if last_look != look_dir:
		last_look = look_dir
		update_anims()
		update_arms()
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
		if arm.name != ActiveLArm.name and arm.name != ActiveRArm.name:
			arm.rotation = marker_dict[look_dir][Arms.find(arm)].rotation


func update_arm_sprites() -> void:
	LArm1.texture = DATA.EQUIPMENT.LArm1.texture
	LArm2.texture = DATA.EQUIPMENT.LArm2.texture
	RArm1.texture = DATA.EQUIPMENT.RArm1.texture
	RArm2.texture = DATA.EQUIPMENT.RArm2.texture


func update_anims() -> void:
	# Updates the blend positions of all animations to reflect the current look direction
	$AnimationHandlers/AnimationTree["parameters/Idle/blend_position"] = look_dir
	$AnimationHandlers/AnimationTree["parameters/Walk/blend_position"] = look_dir
