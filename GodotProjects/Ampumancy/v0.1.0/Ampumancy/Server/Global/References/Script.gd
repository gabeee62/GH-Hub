extends Node2D

@export_category("Tile Effects")
@export var TileEffects: Array[String]

@export_category("Character Sprites")
@export_group("Player")
@export var Hat: Texture2D = preload("res://Common/Textures/Entities/Player/New/Hat.png")
@export var Head: Texture2D = preload("res://Common/Textures/Entities/Player/New/Head.png")
@export var Cloak: Texture2D = preload("res://Common/Textures/Entities/Player/New/Cloak.png")
@export var Robes: Texture2D = preload("res://Common/Textures/Entities/Player/New/Robes.png")
@export var Body: Texture2D = preload("res://Common/Textures/Entities/Player/New/Body.png")

@export_category("Cursors")
@export var GameCursor: Texture2D = preload("res://Common/Textures/UI/HUD/cursor.png")

@export_category("Backgrounds")
@export var Background1: Array[Texture2D]
@export var Background2: Array[Texture2D]
@export var Background3: Array[Texture2D]
@export var Background4: Array[Texture2D]
@export var Background5: Array[Texture2D]
@export var Background6: Array[Texture2D]
@export var Background7: Array[Texture2D]
@export var Background8: Array[Texture2D]
@export var ScrollOffsets: Dictionary # DON'T MESS WITH THIS -- LOTS OF WORK WILL RESET

@export_category("Arm Syngergies") # TODO: Make system for arm synergies
@export var BoostGrid: Array[Array] = [
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0]]
@export var DuosisGrid: Array[Array] = [
	[-1, 0, 0, 0],
	[0, -1, 0, 0],
	[0, 0, -1, 0],
	[0, 0, 0, -1]]
