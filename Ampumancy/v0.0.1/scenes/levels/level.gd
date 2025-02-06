extends Node2D
class_name Level

@export var stats: Stats

func _process(delta: float):
	$Menus/HeadsUpDisplay.xcoord = $Player.xcoord
	$Menus/HeadsUpDisplay.ycoord = $Player.ycoord
	
	if Input.is_action_just_pressed("zoom in"):
		$Player/PlayerCam.zoom += Vector2(.1, .1)
	if Input.is_action_just_pressed("zoom out"):
		$Player/PlayerCam.zoom -= Vector2(.1, .1)
