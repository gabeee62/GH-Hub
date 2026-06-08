extends Resource
class_name Ruleset

enum Type {TOTALITY, CLASSIC, TRAINING}

@export_group("General")
@export var GameType: Type
@export var TeamSize: int
@export_group("", "")

@export_group("Classic Settings")
@export_subgroup("Timers")
@export var RoundTime: int
@export_group("", "")

@export_group("Totality Settings")
@export_subgroup("Timers")
@export var LastPointTime: int
@export var SuddenDeathTime: int
@export_group("", "")

@export_group("Training Settings")
@export_group("", "")
