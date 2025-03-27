extends PanelContainer

var active_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/frames/active_arm_frame.png")
var inactive_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/frames/inactive_arm_frame.png")

var player_ready: bool = false


func _ready() -> void:
	SignalBus.player_ready.connect(set_player_ready)


func set_player_ready() -> void:
	player_ready = not player_ready


func _process(_delta: float) -> void:
	update_active_arms_ui()
	update_arm_textures()


func update_active_arms_ui() -> void:
	if Globals.PLAYER.DATA.EQUIPMENT.ActiveLArm.name == Globals.PLAYER.DATA.EQUIPMENT.LArm1.name:
		$HBoxContainer/LArms/LArm1.texture = active_frame
		$HBoxContainer/LArms/LArm2.texture = inactive_frame
	else:
		$HBoxContainer/LArms/LArm1.texture = inactive_frame
		$HBoxContainer/LArms/LArm2.texture = active_frame
	if Globals.PLAYER.DATA.EQUIPMENT.ActiveRArm.name == Globals.PLAYER.DATA.EQUIPMENT.RArm1.name:
		$HBoxContainer/RArms/RArm1.texture = active_frame
		$HBoxContainer/RArms/RArm2.texture = inactive_frame
	else:
		$HBoxContainer/RArms/RArm1.texture = inactive_frame
		$HBoxContainer/RArms/RArm2.texture = active_frame


func update_arm_textures() -> void:
	if $HBoxContainer/LArms/LArm1/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.LArm1.ui_texture:
		$HBoxContainer/LArms/LArm1/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.LArm1.ui_texture
	if $HBoxContainer/LArms/LArm2/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.LArm2.ui_texture:
		$HBoxContainer/LArms/LArm2/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.LArm2.ui_texture
	if $HBoxContainer/RArms/RArm1/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.RArm1.ui_texture:
		$HBoxContainer/RArms/RArm1/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.RArm1.ui_texture
	if $HBoxContainer/RArms/RArm2/ArmTexture.texture != Globals.PLAYER.DATA.EQUIPMENT.RArm2.ui_texture:
		$HBoxContainer/RArms/RArm2/ArmTexture.texture = Globals.PLAYER.DATA.EQUIPMENT.RArm2.ui_texture
