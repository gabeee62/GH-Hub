extends Node

#             --- ABOUT ---
# This script provides global access to game
# enumerators and utility functions. Useful
# for tracking game states, item types, etc.

enum GAME_STATES {RUNNING, PAUSED}
enum GAME_TYPES {PLATFORMER, TOPDOWN}

enum ERR_CODES {TS1, CS1, CS2, CS3}

enum SCENE_CHANGE_TYPES {FW, FB}

enum EVENT_TYPES {AREA, ACTION}

enum DIFFICULTY_TYPES {EASY, NORMAL, HARD, HARDCORE}


func yes_no(torf: bool) -> String:
	if torf:
		return "YES"
	else:
		return "NO"


func power_of(value: float, exponent: int) -> float:
	for i in range(exponent - 1):
		value *= value
	return value
