@tool
extends Node2D

@onready var movedata: MovementData = $"../..".movedata
@onready var equipment: PlayerEquipment = $"../..".equipment

var arms: Array[Node]

var active_arm: Sprite2D
var inactive_arm: Sprite2D


func _ready() -> void:
	arms = get_children()
	update_arm_sprites()
	reset_active()


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		rotate_arms()
	update_arm_sprites()


func rotate_arms() -> void:
	active_arm.look_at(get_global_mouse_position())
	inactive_arm.rotation_degrees = 90 - (45 * movedata.look_direction)


func update_arm_sprites() -> void:
	$RArm1.texture = equipment.RArm1.texture
	$RArm2.texture = equipment.RArm2.texture


func reset_active() -> void:
	if arms[0].name.ends_with("1"):
		active_arm = arms[0]
		inactive_arm = arms[1]
	else:
		active_arm = arms[1]
		inactive_arm = arms[0]


func switch_active() -> void:
	var last_active = active_arm
	active_arm = inactive_arm
	inactive_arm = last_active


func flip_arms() -> void:
	move_child(get_child(0), -1)
