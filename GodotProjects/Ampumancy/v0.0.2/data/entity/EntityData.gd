extends Resource
class_name EntityData

enum MOTION_MODES {STATIONARY, WANDER, HUNT, ROOTED}

@export var NAME: String
@export var TEAM: Util.TEAMS
@export var MOTION_MODE: MOTION_MODES

@export var HEALTH: int
