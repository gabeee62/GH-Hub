extends Node

@export_group("Outfit")
@export var Hat: Array[Texture2D]
@export var Head: Array[Texture2D]
@export var Eyes: Array[Texture2D]
@export var Cloak: Array[Texture2D]
@export var Body: Array[Texture2D]
@export_group("", "")

@export_group("Game Backgrounds")
@onready var clouds: Dictionary = {
	1: [clouds1, clouds1_auto],
	2: [clouds2, clouds2_auto],
	3: [clouds3, clouds3_auto], 
	4: [clouds4, clouds4_auto], 
	5: [clouds5, clouds5_auto], 
	6: [clouds6, clouds6_auto], 
	7: [clouds7, clouds7_auto], 
	8: [clouds8, clouds8_auto]}
@export_subgroup("Clouds/1")
@export var clouds1: Array[Texture2D]
@export var clouds1_auto: Array[float]
@export_subgroup("Clouds/2")
@export var clouds2: Array[Texture2D]
@export var clouds2_auto: Array[float]
@export_subgroup("Clouds/3")
@export var clouds3: Array[Texture2D]
@export var clouds3_auto: Array[float]
@export_subgroup("Clouds/4")
@export var clouds4: Array[Texture2D]
@export var clouds4_auto: Array[float]
@export_subgroup("Clouds/5")
@export var clouds5: Array[Texture2D]
@export var clouds5_auto: Array[float]
@export_subgroup("Clouds/6")
@export var clouds6: Array[Texture2D]
@export var clouds6_auto: Array[float]
@export_subgroup("Clouds/7")
@export var clouds7: Array[Texture2D]
@export var clouds7_auto: Array[float]
@export_subgroup("Clouds/8")
@export var clouds8: Array[Texture2D]
@export var clouds8_auto: Array[float]
@export_group("", "")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
