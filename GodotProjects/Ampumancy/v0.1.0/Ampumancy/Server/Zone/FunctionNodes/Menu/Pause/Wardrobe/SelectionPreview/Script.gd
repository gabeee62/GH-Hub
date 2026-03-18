extends CanvasGroup
class_name SelectionPreview

var Selections: Array[int]


func _process(_delta: float) -> void:
	update_player_sprite()


func update_player_sprite() -> void:
	$Hat.texture = Globals.CurrentPlayer.Data.Wardrobe.Set.Hats[str(Selections[0] + 1)]
	$Head.texture = Globals.CurrentPlayer.Data.Wardrobe.Set.Faces[str(Selections[1] + 1)]
	$Eyes.texture = Globals.CurrentPlayer.Data.Wardrobe.Set.Eyes[str(Selections[2] + 1)]
	$Cloak.texture = Globals.CurrentPlayer.Data.Wardrobe.Set.Cloaks[str(Selections[3] + 1)]
	$Robes.texture = Globals.CurrentPlayer.Data.Wardrobe.Set.Robes[str(Selections[4] + 1)]
