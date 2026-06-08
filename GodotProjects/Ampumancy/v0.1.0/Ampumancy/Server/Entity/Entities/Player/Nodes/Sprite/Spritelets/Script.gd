@tool
extends Sprite2D

enum SpriteParts {HAT, HEAD, CLOAK, ROBES, BODY}
@export var sprite_part: SpriteParts

var sprite_sheet: Texture2D


func _ready() -> void:
	match sprite_part:
		SpriteParts.HAT:
			sprite_sheet = References.Hat
		SpriteParts.HEAD:
			sprite_sheet = References.Head
		SpriteParts.CLOAK:
			sprite_sheet = References.Cloak
		SpriteParts.ROBES:
			sprite_sheet = References.Robes
		SpriteParts.BODY:
			sprite_sheet = References.Body
