@tool
extends Panel
class_name WardrobeSelectButton

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


func _on_left_pressed() -> void:
	if WardrobePartValue > 0:
		WardrobePartValue -= 1
	LeftPressed.emit()


func _on_right_pressed() -> void:
	if WardrobePartValue < len(Globals.CurrentPlayer.Data.Wardrobe.Set) - 1:
		WardrobePartValue += 1
	RightPressed.emit()
