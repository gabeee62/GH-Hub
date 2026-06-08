extends Control


func _process(_delta: float) -> void:
	if Globals.CurrentPlayer:
		global_position = Globals.CurrentPlayer.global_position
