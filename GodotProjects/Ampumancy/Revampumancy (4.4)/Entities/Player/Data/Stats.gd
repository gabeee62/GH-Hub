extends Resource
class_name PlayerStats

@export_group("Health")
@export var max_health: int
var gold_health_limit: int = 200
@export var max_gold_health: int
@export var current_health: int
@export var current_gold_health: int

@export_group("Mana")
var node_limit: int = 16
@export var max_mana_nodes: int
@export var max_mystic_nodes: int
@export var max_solar_nodes: int
@export var current_mana_nodes: int
@export var current_mystic_nodes: int
@export var current_solar_nodes: int
