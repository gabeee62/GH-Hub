extends Node2D

var player_root: Player

@export var left_or_right: bool
@export var active_arm: Sprite2D
@export var inactive_arm: Sprite2D

var left_facing_arms_pos: Array[Vector2] = [
	Vector2(0, 1), Vector2(0, 3),
	Vector2(4, 3), Vector2(4, 1),]
var right_facing_arms_pos: Array[Vector2] = [
	Vector2(-4, 3), Vector2(-4, 1),
	Vector2(0, 1), Vector2(0, 3)]

var inactive_rest_rotation: float = 45.0


func _ready() -> void:
	player_root = get_parent().get_parent()
	if left_or_right:
		set_arm_texture(0, player_root.data.inventory.equipment.RArm1.arm_texture)
		set_arm_texture(1, player_root.data.inventory.equipment.RArm2.arm_texture)
	else:
		set_arm_texture(0, player_root.data.inventory.equipment.LArm1.arm_texture)
		set_arm_texture(1, player_root.data.inventory.equipment.LArm2.arm_texture)


func _process(_delta: float) -> void:
	active_arm.look_at(get_global_mouse_position())
	inactive_arm.rotation_degrees = inactive_rest_rotation


func switch_arms() -> void:
	var last_active_arm: Sprite2D = active_arm
	active_arm = inactive_arm
	inactive_arm = last_active_arm


# Flips the player's arm sprites to correctly
# display when the player turns around
func flip_arms() -> void:
	move_child(get_child(0), -1)
	inactive_rest_rotation = -270 - 45 * get_parent().current_x
	update_arm_positions()


# Updates the arm sprite positions depending
# on the direction the player is facing
func update_arm_positions() -> void:
	var current_pos_array: Array
	if get_parent().current_x > 0:
		current_pos_array = right_facing_arms_pos
	elif get_parent().current_x < 0:
		current_pos_array = left_facing_arms_pos
	
	var index: int = 0
	if left_or_right:
		index += 2
	for i: Sprite2D in get_children():
		i.position = current_pos_array[index]
		index += 1


# Takes in either a 0 or 1 to determine whether
# to change the texture of Arm 1 or Arm 2.
func set_arm_texture(child_index: int, texture: Texture2D) -> void:
	var children: Array[Sprite2D]
	if left_or_right:
		children = [$RArm1, $RArm2]
	else:
		children = [$LArm1, $LArm2]
	var arm: Sprite2D = children[child_index]
	arm.texture = texture


func _on_left_arm_switched() -> void:
	if not left_or_right:
		switch_arms()


func _on_right_arm_switched() -> void:
	if left_or_right:
		switch_arms()
