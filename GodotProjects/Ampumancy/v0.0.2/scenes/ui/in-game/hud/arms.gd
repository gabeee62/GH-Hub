extends PanelContainer

var active_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/frames/active_arm_frame.png")
var inactive_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/frames/inactive_arm_frame.png")

var active_l: bool = true
var active_r: bool = true

var player_ready: bool = false


func _ready() -> void:
	SignalBus.player_ready.connect(set_player_ready)


func set_player_ready() -> void:
	player_ready = not player_ready


func _process(_delta: float) -> void:
	update_active_arms_ui()
	update_arm_textures()


func update_active_arms_ui() -> void:
	if Input.is_action_just_pressed("SWITCHL"):
		if active_l:
			$HBoxContainer/LArms/LArm1.texture = inactive_frame
			$HBoxContainer/LArms/LArm2.texture = active_frame
		else:
			$HBoxContainer/LArms/LArm1.texture = active_frame
			$HBoxContainer/LArms/LArm2.texture = inactive_frame
		active_l = not active_l
	if Input.is_action_just_pressed("SWITCHR"):
		if active_r:
			$HBoxContainer/RArms/RArm1.texture = inactive_frame
			$HBoxContainer/RArms/RArm2.texture = active_frame
		else:
			$HBoxContainer/RArms/RArm1.texture = active_frame
			$HBoxContainer/RArms/RArm2.texture = inactive_frame
		active_r = not active_r


func update_arm_textures() -> void:
	if $HBoxContainer/LArms/LArm1/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.LArm1.Arm.ui_texture:
		$HBoxContainer/LArms/LArm1/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.LArm1.Arm.ui_texture
	if $HBoxContainer/LArms/LArm2/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.LArm2.Arm.ui_texture:
		$HBoxContainer/LArms/LArm2/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.LArm2.Arm.ui_texture
	if $HBoxContainer/RArms/RArm1/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.RArm1.Arm.ui_texture:
		$HBoxContainer/RArms/RArm1/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.RArm1.Arm.ui_texture
	if $HBoxContainer/RArms/RArm2/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.RArm2.Arm.ui_texture:
		$HBoxContainer/RArms/RArm2/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.RArm2.Arm.ui_texture
