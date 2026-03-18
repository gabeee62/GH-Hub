@tool
extends CanvasGroup

@onready var Parent: Player = $".."
@onready var Equipment: PlayerEquipmentData = Parent.Data.Equipment

var LastSelection: Array[int]


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	#update_player_sprite(Parent.Data.Wardrobe.Selection) FIXME: Needs to grab from something that isn't the player
	update_arm_sprites()


func game_process(_delta: float) -> void:
	rotate_arms()
	update_player_sprite(Parent.Data.Wardrobe.Selection)
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
	match Equipment.ActiveLeft:
		1:
			$Left_Arms/Primary.look_at(get_global_mouse_position())
			$Left_Arms/Secondary.rotation_degrees = 90 - (40 * Parent.Data.LastFaced)
		-1:
			$Left_Arms/Primary.rotation_degrees = 90 - (45 * Parent.Data.LastFaced)
			$Left_Arms/Secondary.look_at(get_global_mouse_position())
	match Equipment.ActiveRight:
		1:
			$Right_Arms/Primary.look_at(get_global_mouse_position())
			$Right_Arms/Secondary.rotation_degrees = 90 - (40 * Parent.Data.LastFaced)
		-1:
			$Right_Arms/Primary.rotation_degrees = 90 - (45 * Parent.Data.LastFaced)
			$Right_Arms/Secondary.look_at(get_global_mouse_position())


func update_player_sprite(selections: Array[int]) -> void:
	if selections != LastSelection:
		LastSelection = selections
		$Hat.texture = Parent.Data.Wardrobe.Set.Hats[str(selections[0] + 1)]
		$Head.texture = Parent.Data.Wardrobe.Set.Faces[str(selections[1] + 1)]
		$Eyes.texture = Parent.Data.Wardrobe.Set.Eyes[str(selections[2] + 1)]
		$Left_Cloak.texture = Parent.Data.Wardrobe.Set.Cloaks[str(selections[3] + 1)]
		$Right_Cloak.texture = Parent.Data.Wardrobe.Set.Cloaks[str(selections[3] + 1)]
		$Robes.texture = Parent.Data.Wardrobe.Set.Robes[str(selections[4] + 1)]


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
