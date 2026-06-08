@tool
extends CanvasGroup
class_name PlayerSprite

@onready var Parent: Player = $".."

var LastSelection: Array[int]


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	update_arm_sprites()


func game_process(_delta: float) -> void:
	rotate_arms()
	update_animation_parameters()
	update_blend_positions()


func flip_player() -> void:
	var index: int = -1
	for i in get_children().slice(3, 7):
		move_child(i, index)
		index -= 1
	$Left_Arms.flip_arms()
	$Right_Arms.flip_arms()


func rotate_arms() -> void:
	match Parent.Data.Equipment.ActiveLeft:
		1:
			$Left_Arms/Primary.look_at(get_global_mouse_position())
			$Left_Arms/Secondary.rotation_degrees = 90 - (40 * Parent.Data.LastFaced)
		-1:
			$Left_Arms/Primary.rotation_degrees = 90 - (45 * Parent.Data.LastFaced)
			$Left_Arms/Secondary.look_at(get_global_mouse_position())
	match Parent.Data.Equipment.ActiveRight:
		1:
			$Right_Arms/Primary.look_at(get_global_mouse_position())
			$Right_Arms/Secondary.rotation_degrees = 90 - (40 * Parent.Data.LastFaced)
		-1:
			$Right_Arms/Primary.rotation_degrees = 90 - (45 * Parent.Data.LastFaced)
			$Right_Arms/Secondary.look_at(get_global_mouse_position())


func update_arm_sprites() -> void:
	$Left_Arms/Primary.texture = Parent.Data.Equipment.PrimaryLeft.texture
	$Left_Arms/Secondary.texture = Parent.Data.Equipment.SecondaryLeft.texture
	$Right_Arms/Primary.texture = Parent.Data.Equipment.PrimaryRight.texture
	$Right_Arms/Secondary.texture = Parent.Data.Equipment.SecondaryRight.texture


func update_animation_parameters() -> void:
	match Parent.Data.GroundState:
		Parent.Data.GroundStates.GROUNDED:
			if Parent.WASDVector.x != 0.0:
				enable_only("walk", ["idle", "walk", "jump"])
			else:
				enable_only("idle", ["idle", "walk", "jump"])
		Parent.Data.GroundStates.AIRBORNE:
			enable_only("jump", ["idle", "walk", "jump"])


func update_blend_positions() -> void:
	$"../AnimationTree"["parameters/Idle/blend_position"] = Parent.track_mouse()
	$"../AnimationTree"["parameters/Walk/blend_position"] = Parent.track_mouse()
	$"../AnimationTree"["parameters/Jump/blend_position"] = Parent.track_mouse()


func enable_only(enabled: String, list: Array[String]) -> void:
	for i in list:
		if i == enabled:
			$"../AnimationTree"["parameters/conditions/" + i] = true
		else:
			$"../AnimationTree"["parameters/conditions/" + i] = false
