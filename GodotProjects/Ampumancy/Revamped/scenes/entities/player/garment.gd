@tool
extends Sprite2D

var hats: Array[Texture2D] = [
	preload("res://graphics/entities/player/hat/hat.png"),
	preload("res://graphics/entities/player/hat/hat_2.png"),
	preload("res://graphics/entities/player/hat/hat_3.png"),]
var heads: Array[Texture2D] = [
	preload("res://graphics/entities/player/head/head.png"),]
var eyes: Array[Texture2D] = [
	preload("res://graphics/entities/player/eyes/eyes.png"),
	preload("res://graphics/entities/player/eyes/eyes_2.png"),
	preload("res://graphics/entities/player/eyes/eyes_3.png"),
	preload("res://graphics/entities/player/eyes/eyes_4.png"),
	preload("res://graphics/entities/player/eyes/eyes_5.png"),
	preload("res://graphics/entities/player/eyes/eyes_6.png"),]
var cloaks: Array[Texture2D] = [
	preload("res://graphics/entities/player/cloak/cloak.png"),
	preload("res://graphics/entities/player/cloak/cloak_2.png"),]
var bodies: Array[Texture2D] = [
	preload("res://graphics/entities/player/body/body.png"),]

@export var garment_index: int
@export var color_index: int
var last_color_index: int


func _process(_delta: float) -> void:
	if color_index != last_color_index:
		last_color_index = color_index
		var garments: Array = [hats, heads, eyes, cloaks, bodies]
		texture = garments[garment_index][color_index]
