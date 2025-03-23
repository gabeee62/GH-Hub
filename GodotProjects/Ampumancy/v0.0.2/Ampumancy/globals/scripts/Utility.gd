extends Node


func power_of(value: float, exponent: int) -> float:
	for i in range(exponent - 1):
		value *= value
	return value
