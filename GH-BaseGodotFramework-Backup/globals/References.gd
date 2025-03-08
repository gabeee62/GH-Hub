extends Node

#             --- ABOUT ---
# This script acts in a similar fashion to 
# Globals.gd, but is intended for cosmetic 
# singletons such as commonly used colors,
# skins, icons, etc.

@export_group("Example Colors")
@export var Blue: Color = Color.BLUE
@export var Red: Color = Color.RED
@export var Green: Color = Color.GREEN
@export var Yellow: Color = Color.YELLOW

@export_group("Example Icons")
@export var Sword: Texture2D
@export var Apple: Texture2D
@export var Potion: Texture2D
