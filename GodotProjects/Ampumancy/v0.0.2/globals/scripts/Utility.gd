extends Node

enum GAME_STATES {RUNNING, PAUSED}

enum TEAMS {NONE, PLAYER, T1, T2, T3, T4}

enum ITEM_TYPES {NONE, ITEM, CONSUMABLE, ARM, KEY}


func power_of(value: float, exponent: int) -> float:
	for i in range(exponent - 1):
		value *= value
	return value
