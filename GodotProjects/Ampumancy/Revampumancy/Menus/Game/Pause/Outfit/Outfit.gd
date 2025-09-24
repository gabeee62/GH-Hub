extends PanelContainer

signal back()

@export var last_outfit: Array[int]

@export var hat_picker: OutfitPicker
@export var face_picker: OutfitPicker
@export var eyes_picker: OutfitPicker
@export var cloak_picker: OutfitPicker
@export var robes_picker: OutfitPicker


func _ready() -> void:
	last_outfit[0] = Singletons.player.outfit.Hat
	last_outfit[1] = Singletons.player.outfit.Face
	last_outfit[2] = Singletons.player.outfit.Eyes
	last_outfit[3] = Singletons.player.outfit.Cloak
	last_outfit[4] = Singletons.player.outfit.Robes


func _on_confirm_pressed() -> void:
	Singletons.player.outfit.Hat = int(hat_picker.value.text) - 1
	Singletons.player.outfit.Face = int(face_picker.value.text) - 1
	Singletons.player.outfit.Eyes = int(eyes_picker.value.text) - 1
	Singletons.player.outfit.Cloak = int(cloak_picker.value.text) - 1
	Singletons.player.outfit.Robes = int(robes_picker.value.text) - 1
	last_outfit[0] = int(hat_picker.value.text) - 1
	last_outfit[1] = int(face_picker.value.text) - 1
	last_outfit[2] = int(eyes_picker.value.text) - 1
	last_outfit[3] = int(cloak_picker.value.text) - 1
	last_outfit[4] = int(robes_picker.value.text) - 1
	back.emit()


func _on_cancel_pressed() -> void:
	hat_picker.preview_sprite.texture = References.exiled_hats[last_outfit[0]]
	face_picker.preview_sprite.texture = References.exiled_faces[last_outfit[1]]
	eyes_picker.preview_sprite.texture = References.exiled_eyes[last_outfit[2]]
	cloak_picker.preview_sprite.texture = References.exiled_cloaks[last_outfit[3]]
	robes_picker.preview_sprite.texture = References.exiled_robes[last_outfit[4]]
	hat_picker.index = last_outfit[0] + 1
	face_picker.index = last_outfit[1] + 1
	eyes_picker.index = last_outfit[2] + 1
	cloak_picker.index = last_outfit[3] + 1
	robes_picker.index = last_outfit[4] + 1
	back.emit()
