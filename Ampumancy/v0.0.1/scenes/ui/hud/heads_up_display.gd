extends Control

# ADD HEALTH + MANA BARS
# ADD ARMS UI

var xcoord: int
var ycoord: int


func _process(_delta: float) -> void:
	$XYCoords.text = "x: " + str(xcoord) + " y: " + str(ycoord)
