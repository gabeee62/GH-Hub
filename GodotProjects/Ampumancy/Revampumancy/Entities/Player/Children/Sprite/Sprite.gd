@tool
extends CanvasGroup

var outfit: PlayerOutfit


func _ready() -> void:
	outfit = $"..".outfit


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process(delta)


func tool_process(delta: float) -> void:
	$Hat.texture = References.exiled_hats[outfit.Hat]
	$Face.texture = References.exiled_faces[outfit.Face]
	$Eyes.texture = References.exiled_eyes[outfit.Eyes]
	$CloakL.texture = References.exiled_cloaks[outfit.Cloak]
	$CloakR.texture = References.exiled_cloaks[outfit.Cloak]
	$Robes.texture = References.exiled_robes[outfit.Robes]


func game_process(delta: float) -> void:
	pass


func flip_sprite() -> void:
	reorder_spritelets()
	$RArms.flip_arms()
	$LArms.flip_arms()


func reorder_spritelets() -> void:
	var spritelets: Array = get_children().slice(3)
	for spritelet in spritelets:
		move_child(spritelet, 3)
