extends CharacterBody2D
class_name Player

signal update_health(health: int, gold_health: int, max_health: int, max_gold_health: int)
signal update_mana(mana_points: int, mystic_points: int)
signal finished(max_health: int, health: int, max_gold_health: int, gold_health: int, max_mana_points: int, mana_points: int, mystic_points: int)

signal switch_l()
signal switch_r()

# GAME COORDINATES
var xcoord: int
var ycoord: int

var last_direction: int = 1

var godmode: bool = false

var team: Utility.TEAMS = Utility.TEAMS.PLAYER

# JUMP CALCULATIONS
@onready var jump_velocity: float = ((-2.0 * jump_height) / seconds_to_peak)
@onready var jump_gravity:  float = ((2.0 * jump_height) / (seconds_to_peak * seconds_to_peak))
@onready var fall_gravity:  float = ((2.0 * jump_height) / (seconds_to_fall * seconds_to_fall))

# JUMP VARIABLES (CHANGE IN INSPECTOR)
@export var jump_height: float
@export var seconds_to_peak: float
@export var seconds_to_fall: float

@export var stats: Stats
@export var equipment: Equipment
@export var inventory: Inventory

var left_arms: Array[Arm]
var right_arms: Array[Arm]

var active_left_arm: Sprite2D
var inactive_left_arm: Sprite2D
var active_right_arm: Sprite2D
var inactive_right_arm: Sprite2D

var active_left_arm_marker: Marker2D
var inactive_left_arm_marker: Marker2D
var active_right_arm_marker: Marker2D
var inactive_right_arm_marker: Marker2D

func _ready() -> void:
	stats.health = 79
	stats.gold_health = 0
	stats.current_mana_points = stats.max_mana_points
	stats.current_mystic_points = stats.max_mystic_points
	finished.emit(stats.max_health, stats.health, stats.max_gold_health, stats.gold_health, stats.max_mana_points, stats.current_mana_points, stats.current_mystic_points)
	
	active_left_arm = $Sprite/LArms/LArm1
	active_right_arm = $Sprite/RArms/RArm1
	inactive_left_arm = $Sprite/LArms/LArm2
	inactive_right_arm = $Sprite/RArms/RArm2
	active_left_arm_marker = $Sprite/LArms/LArm1/EmissionMarker
	inactive_left_arm_marker = $Sprite/LArms/LArm2/EmissionMarker
	active_right_arm_marker = $Sprite/RArms/RArm1/EmissionMarker
	inactive_right_arm_marker = $Sprite/RArms/RArm2/EmissionMarker
	stats.active_left_arm = equipment.left_arm_1
	stats.inactive_left_arm = equipment.left_arm_2
	stats.active_right_arm = equipment.right_arm_1
	stats.inactive_right_arm = equipment.right_arm_2


func _process(delta: float) -> void:
	
	# IN-GAME COORDINATES
	xcoord = (position.x - 35) / 40
	ycoord = (position.y + 65) / -40
	
	# GRAVITY
	velocity.y += get_grav() * delta
	
	# GOD MODE (REMOVE BEFORE RELEASE)
	if Input.is_action_just_pressed("god_toggle"):
		godmode = not godmode
	
	# MANA REGEN AND CONSUMATION
	if Input.is_action_just_pressed("regen"):
		mana_regen(1)
	if Input.is_action_just_pressed("consume"):
		mana_consume(2)
	
	# SWITCH ACTIVE ARMS
	if Input.is_action_just_pressed("switch_left"):
		switch_left()
	if Input.is_action_just_pressed("switch_right"):
		switch_right()
	
	# CAST ACTIVE ARM SPELLS
	if Input.is_action_just_pressed("cast_left"):
		if stats.active_left_arm.spell != Utility.SPELLS.NONE:
			var spell_array: Array = SpellLibrary.cast_spell(stats.active_left_arm.spell)
			var spell_scene: PackedScene = spell_array[0]
			var cost: int = spell_array[1]
			var spell: Spell
			if mana_consume(cost):
				spell = spell_scene.instantiate()
				spell.team = team
				spell.position = active_left_arm_marker.global_position
			SignalBus.spell_cast.emit(spell)
	if Input.is_action_just_pressed("cast_right"):
		if stats.active_right_arm.spell != Utility.SPELLS.NONE:
			var spell_array: Array = SpellLibrary.cast_spell(stats.active_right_arm.spell)
			var spell_scene: PackedScene = spell_array[0]
			var cost: int = spell_array[1]
			var spell: Spell
			if mana_consume(cost):
				spell = spell_scene.instantiate()
				spell.team = team
				spell.position = active_right_arm_marker.global_position
			SignalBus.spell_cast.emit(spell)
	
	movement()
	rotate_arms()
	flip_arms()
	update_arms()


func movement() -> void:
	var body_sprites: Array[Sprite2D] = [$Sprite/Hat, $Sprite/Head, $Sprite/Eyes, $Sprite/CloakR, $Sprite/Body, $Sprite/CloakL]
	var arm_sprites: Array[Sprite2D] = [$Sprite/RArms/RArm1, $Sprite/RArms/RArm2, $Sprite/LArms/LArm2, $Sprite/LArms/LArm1]
	# IF H MOUSE POSITION IS GREATER THAN PLAYER'S
	if get_global_mouse_position().x > position.x:
		last_direction = 1
		# IF PLAYER PRESSES "WALK RIGHT"
		if Input.is_action_pressed("right"):
			velocity.x = stats.current_movespeed
			if is_on_floor():
				$AnimationPlayer.play("walk_r")
			else:
				$AnimationPlayer.play("jump_r")
		# IF PLAY PRESSES "WALK LEFT"
		if Input.is_action_pressed("left"):
			velocity.x = -1 * stats.current_movespeed
			if is_on_floor():
				$AnimationPlayer.play("walk_r")
			else:
				$AnimationPlayer.play("jump_r")
		# IDLE ANIMATION SET TO IDLE R IF MOUSE IS FARTHER RIGHT THAN PLAYER
		if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			velocity.x = 0
			$AnimationPlayer.play("idle_r")
		for i in body_sprites:
			i.flip_h = false
		for i in arm_sprites:
			i.flip_v = false
	else:
		last_direction = -1
		if Input.is_action_pressed("right"):
			velocity.x = stats.current_movespeed
			if is_on_floor():
				$AnimationPlayer.play("walk_l")
			else:
				$AnimationPlayer.play("jump_l")
		if Input.is_action_pressed("left"):
			velocity.x = -1 * stats.current_movespeed
			if is_on_floor():
				$AnimationPlayer.play("walk_l")
			else:
				$AnimationPlayer.play("jump_l")
		if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			velocity.x = 0
			$AnimationPlayer.play("idle_l")
		for i in body_sprites:
			i.flip_h = true
		for i in arm_sprites:
			i.flip_v = true
	# JUMP
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			stats.current_extra_jumps = stats.max_extra_jumps
			jump()
		elif stats.current_extra_jumps > 0:
			jump()
			stats.current_extra_jumps -= 1
	
	# GODMODE WIP
	
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


func rotate_arms() -> void:
	active_left_arm.look_at(get_global_mouse_position())
	active_right_arm.look_at(get_global_mouse_position())


func flip_arms() -> void:
	if last_direction == 1:
		inactive_left_arm.rotation_degrees = 66.3
		inactive_right_arm.rotation_degrees = 66.3
		$Sprite/RArms/RArm2.position = $RFaceArmMarkers/RArm2.position
		$Sprite/LArms/LArm2.position = $RFaceArmMarkers/LArm2.position 
		$Sprite.move_child($Sprite/CloakR, 3)
		$Sprite.move_child($Sprite/RArms, 4)
		$Sprite.move_child($Sprite/Body, 5)
		$Sprite.move_child($Sprite/LArms, 6)
		$Sprite.move_child($Sprite/CloakL, 7)
		$Sprite/RArms.move_child($Sprite/RArms/RArm1, 0)
		$Sprite/LArms.move_child($Sprite/LArms/LArm1, 1)
	else:
		inactive_left_arm.rotation_degrees = 113.7
		inactive_right_arm.rotation_degrees = 113.7
		$Sprite/RArms/RArm2.position = $LFaceArmMarkers/RArm2.position
		$Sprite/LArms/LArm2.position = $LFaceArmMarkers/LArm2.position
		$Sprite.move_child($Sprite/CloakL, 3)
		$Sprite.move_child($Sprite/LArms, 4)
		$Sprite.move_child($Sprite/Body, 5)
		$Sprite.move_child($Sprite/RArms, 6)
		$Sprite.move_child($Sprite/CloakR, 7)
		$Sprite/RArms.move_child($Sprite/RArms/RArm1, 1)
		$Sprite/LArms.move_child($Sprite/LArms/LArm1, 0)


func update_arms() -> void:
	$Sprite/RArms/RArm1.texture = equipment.right_arm_1.texture
	$Sprite/RArms/RArm2.texture = equipment.right_arm_2.texture
	$Sprite/LArms/LArm1.texture = equipment.left_arm_1.texture
	$Sprite/LArms/LArm2.texture = equipment.left_arm_2.texture


func switch_left() -> void:
	var active = active_left_arm
	active_left_arm = inactive_left_arm
	inactive_left_arm = active
	active = active_left_arm_marker
	active_left_arm_marker = inactive_left_arm_marker
	inactive_left_arm_marker = active
	active = stats.active_left_arm
	stats.active_left_arm = stats.inactive_left_arm
	stats.inactive_left_arm = active
	switch_l.emit()


func switch_right() -> void:
	var active = active_right_arm
	active_right_arm = inactive_right_arm
	inactive_right_arm = active
	active = active_right_arm_marker
	active_right_arm_marker = inactive_right_arm_marker
	inactive_right_arm_marker = active
	active = stats.active_right_arm
	stats.active_right_arm = stats.inactive_right_arm
	stats.inactive_right_arm = active
	switch_r.emit()


func mana_regen(num: int):
	if stats.current_mana_points + num <= stats.max_mana_points:
		stats.current_mana_points += num
		num -= num
	else:
		stats.current_mana_points += stats.max_mana_points - stats.current_mana_points
		num -= stats.max_mana_points - stats.current_mana_points
		if stats.current_mystic_points + num <= stats.max_mystic_points:
			stats.current_mystic_points += num
		else:
			stats.current_mystic_points = stats.max_mystic_points
	update_mana.emit(stats.current_mana_points, stats.current_mystic_points)


func mana_consume(num: int) -> bool:
	if stats.current_mana_points + stats.current_mystic_points >= num:
		if stats.current_mystic_points > 0:
			if num > stats.current_mystic_points:
				num -= stats.current_mystic_points
				stats.current_mystic_points -= stats.current_mystic_points
				stats.current_mana_points -= num
				num -= num
			else:
				stats.current_mystic_points -= num
				num -= num
		else:
			stats.current_mana_points -= num
			num -= num
	else:
		return false
	update_mana.emit(stats.current_mana_points, stats.current_mystic_points)
	return true


func _on_passive_mana_regen_timeout() -> void:
	mana_regen(int(1 * stats.mana_regen_modifier))


func health_regen(num: int):
	while num > 0:
		if stats.health + num <= stats.max_health:
			stats.health += num
			num -= num
		else:
			num -= stats.max_health - stats.health
			stats.health = stats.max_health
			if stats.gold_health + num <= stats.max_gold_health:
				stats.gold_health += num
				num -= num
			else:
				stats.gold_health = stats.max_gold_health
				num = 0
	update_health.emit(stats.health, stats.gold_health, stats.max_health, stats.max_gold_health)


func damage(num: int):
	while num > 0:
		if stats.gold_health >= num:
			stats.gold_health -= num
			num -= num
		else:
			num -= stats.gold_health
			stats.gold_health -= stats.gold_health
			if stats.health > num:
				stats.health -= num
				num -= num
			else:
				stats.health = 0
				num = 0
				death()
	update_health.emit(stats.health, stats.gold_health, stats.max_health, stats.max_gold_health)


func _on_passive_health_regen_timeout() -> void:
	health_regen(int(2 * stats.health_regen_modifier))


func _on_outfit_changed(hat: Texture2D, head: Texture2D, eyes: Texture2D, cloak: Texture2D, body: Texture2D) -> void:
	$Sprite/Hat.texture = hat
	$Sprite/Head.texture = head
	$Sprite/Eyes.texture = eyes
	$Sprite/CloakR.texture = cloak
	$Sprite/CloakL.texture = cloak
	$Sprite/Body.texture = body


func death():
	pass
