@tool
extends Entity
class_name Player

@export var data: PlayerData

var input_vector: Vector2
var mouse_direction: float


func custom_entity_ready() -> void:
	Globals.player = self


func custom_entity_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	pass


func game_process(delta: float) -> void:
	input_vector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if get_local_mouse_position().x < 0:
		mouse_direction = -1.0
	elif get_local_mouse_position().x > 0:
		mouse_direction = 1.0
	
	update_animation_conditions()
	update_animation_blends()
	
	movement(delta)
	move_and_slide()


func cast_spell(origin_arm: ArmSprite) -> void:
	var spell: Spell = SpellLibrary.base_spell_lib[origin_arm.arm_data.spell_id].instantiate()
	var cast_point: Marker2D = origin_arm.get_child(0)
	spell.global_position = cast_point.global_position
	origin_arm.get_child(0).add_child(spell)


func jump() -> void:
	if is_on_floor():
		velocity.y = data.jump_velocity
	elif data.double_jumps > 0:
		velocity.y = data.jump_velocity
		data.double_jumps -= 1


func get_grav() -> float:
	return data.jump_gravity if velocity.y < 0 else data.fall_gravity


func movement(delta: float) -> void:
	if is_on_floor():
		data.double_jumps = data.max_double_jumps
	
	velocity.y += get_grav() * delta
	velocity.x = velocity.move_toward(Vector2(input_vector.x * data.movespeed, 0), 40).x


# Updates the boolean conditions contained in the AnimationTree node to determine
# which animation should be played.
func update_animation_conditions() -> void:
	if input_vector.x == 0:
		$AnimationTree["parameters/conditions/idle"] = true
		$AnimationTree["parameters/conditions/walk"] = false
	else:
		$AnimationTree["parameters/conditions/idle"] = false
		$AnimationTree["parameters/conditions/walk"] = true


# Updates the blend positions for each player animation blendspace depending on a range of
# inputs, including mouse direction (relative to the player) and WASD movement.
func update_animation_blends() -> void:
	$AnimationTree["parameters/Idle/blend_position"] = mouse_direction
	$AnimationTree["parameters/Walk/blend_position"] = mouse_direction
