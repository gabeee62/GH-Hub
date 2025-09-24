@tool
extends Node

@export var left_right: bool

var arms: Array[Node]

var active_arm: Sprite2D
var inactive_arm: Sprite2D


func _ready() -> void:
	arms = get_children()
	update_arm_sprites()
	reset_active()


func _process(delta: float) -> void:
	update_arm_sprites()


func update_arm_sprites() -> void:
	pass


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
	move_child(get_child(0), 1)
