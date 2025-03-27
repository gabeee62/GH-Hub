extends Node

@export_group("Outfit")
@export var Hat: Array[Texture2D]
@export var Head: Array[Texture2D]
@export var Eyes: Array[Texture2D]
@export var Cloak: Array[Texture2D]
@export var Body: Array[Texture2D]
@export_group("", "")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
