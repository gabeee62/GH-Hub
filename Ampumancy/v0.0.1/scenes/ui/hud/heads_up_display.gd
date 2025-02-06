extends Control

var xcoord: int
var ycoord: int


func _process(delta: float) -> void:
	$XYCoords.text = "X: " + str(xcoord) + "| Y: " + str(ycoord)
