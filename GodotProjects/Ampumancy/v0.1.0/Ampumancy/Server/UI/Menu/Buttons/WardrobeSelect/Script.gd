@tool
extends Panel
class_name WardrobeSelectButton

enum WardrobePart {HAT, EYES, FACE, CLOAK, ROBES}
@export var Part: WardrobePart

signal LeftPressed
signal RightPressed

@export var WardrobePartName: String
@export var WardrobePartValue: int
@export var WardrobePartPosition: int


func _ready() -> void:
	$WardrobePartName.text = WardrobePartName


func _process(_delta: float) -> void:
	$PartSelection.text = str(WardrobePartValue + 1)


func reset() -> void:
	WardrobePartValue = Globals.CurrentPlayer.Data.Wardrobe.Selection[WardrobePartPosition]


func get_part_array(set: WardrobeSet) -> Dictionary:
	match Part:
		WardrobePart.HAT:
			return set.Hats
		WardrobePart.EYES:
			return set.Eyes
		WardrobePart.FACE:
			return set.Faces
		WardrobePart.CLOAK:
			return set.Cloaks
		WardrobePart.ROBES:
			return set.Robes
	var empty_dict: Dictionary = {}
	return empty_dict


func _on_left_pressed() -> void:
	if WardrobePartValue > 0:
		WardrobePartValue -= 1
	LeftPressed.emit()


func _on_right_pressed() -> void:
	#if WardrobePartValue < len(References.) - 1:
	#	WardrobePartValue += 1
	#RightPressed.emit()
	pass
