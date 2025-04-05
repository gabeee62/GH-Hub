extends Sprite2D

var normal_texture: Texture2D = preload("res://media/graphics/objects/structures/save_points/tent/tent.png")
var interact_texture: Texture2D = preload("res://media/graphics/objects/structures/save_points/tent/tent_interactable.png")


func _process(_delta: float) -> void:
	if $CallOnDetect.player_collided:
		texture = interact_texture
	else:
		texture = normal_texture
