extends Node

enum GAME_STATES {RUNNING, PAUSED}

enum DETECT_TRIGGERS {COLLIDE, BUTTON, CONDITION}

enum TEAMS {NONE, PLAYER, T1, T2, T3, T4}

enum ITEM_TYPES {NONE, ITEM, CONSUMABLE, ARM, KEY}
enum ITEM_RARITIES {NA, COMMON, RARE, MYSTIC, MYTHIC, GILDED}
# enum FACTION_COLLECTIONS {}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func save_game() -> void:
	SaveHandler.save_to_disk()


func power_of(value: float, exponent: int) -> float:
	for i in range(exponent - 1):
		value *= value
	return value
