extends Resource
class_name PlayerOutfit

@export var Hat: int
@export var Face: int
@export var Eyes: int
@export var Cloak: int
@export var Robes: int


func clamp_outfit_integers(integer: int, add_subtract: bool) -> int:
	if add_subtract:
		if integer + 1 <= 7:
			return integer + 1
		else:
			return integer
	else:
		if integer - 1 >= 0:
			return integer - 1
		else:
			return integer
