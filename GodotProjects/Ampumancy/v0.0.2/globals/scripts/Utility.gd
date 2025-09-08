extends Node

enum GAME_STATES {RUNNING, PAUSED}

enum DETECT_TRIGGERS {COLLIDE, BUTTON, CONDITION}

enum TEAMS {NONE, PLAYER, T1, T2, T3, T4}
enum DMG_MARK_MODES {SINGULAR, STACKING}

enum ITEM_TYPES {NONE, ITEM, MATERIAL, CONSUMABLE, ARM, KEY}
enum ITEM_RARITIES {NA, COMMON, RARE, MYSTIC, MYTHIC, GILDED}
# enum FACTION_COLLECTIONS {}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func power_of(value: float, exponent: int) -> float:
	if exponent > 0:
		for i in range(exponent - 1):
			value *= value
	elif exponent == 0:
		value = 1.0
	else:
		for i in range(-exponent - 1):
			value *= value
		value = 1 / value
	return value
