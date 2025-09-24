extends HBoxContainer
class_name OutfitPicker

enum OutfitPart {HAT, FACE, EYES, CLOAK, ROBES}

@export var index: int = 1
@export var part: OutfitPart
@export var value: Label
@export var preview_sprite: Sprite2D


func _process(_delta: float) -> void:
	value.text = str(index)


func clamp_index(add_subtract: bool) -> void:
	match part:
		OutfitPart.HAT:
			if add_subtract and index + 1 <= len(References.exiled_hats):
				index += 1
			elif not add_subtract and index - 1 >= 1:
				index -= 1
		OutfitPart.FACE:
			if add_subtract and index + 1 <= len(References.exiled_faces):
				index += 1
			elif not add_subtract and index - 1 >= 1:
				index -= 1
		OutfitPart.EYES:
			if add_subtract and index + 1 <= len(References.exiled_eyes):
				index += 1
			elif not add_subtract and index - 1 >= 1:
				index -= 1
		OutfitPart.CLOAK:
			if add_subtract and index + 1 <= len(References.exiled_cloaks):
				index += 1
			elif not add_subtract and index - 1 >= 1:
				index -= 1
		OutfitPart.ROBES:
			if add_subtract and index + 1 <= len(References.exiled_robes):
				index += 1
			elif not add_subtract and index - 1 >= 1:
				index -= 1
	update_preview()


func update_preview() -> void:
	match part:
		OutfitPart.HAT:
			preview_sprite.texture = References.exiled_hats[index - 1]
		OutfitPart.FACE:
			preview_sprite.texture = References.exiled_faces[index - 1]
		OutfitPart.EYES:
			preview_sprite.texture = References.exiled_eyes[index - 1]
		OutfitPart.CLOAK:
			preview_sprite.texture = References.exiled_cloaks[index - 1]
		OutfitPart.ROBES:
			preview_sprite.texture = References.exiled_robes[index - 1]


func _on_cycle_down_pressed() -> void:
	clamp_index(false)


func _on_cycle_up_pressed() -> void:
	clamp_index(true)
