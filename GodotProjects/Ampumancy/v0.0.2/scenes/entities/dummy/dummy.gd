extends Entity

var normal_texture: Texture2D = preload("res://media/graphics/entities/dummy/dummy.png")
var hovering_texture: Texture2D = preload("res://media/graphics/entities/dummy/dummy_hovering.png")


func _ready() -> void:
	$DamageMarker.text = ""


func on_hit(damage: int) -> void:
	$AnimationPlayer.play("hit")
	$DamageMarker.play_hit(damage)


func _on_mouse_entered() -> void:
	$Sprite/Sprite2D.texture = hovering_texture


func _on_mouse_exited() -> void:
	$Sprite/Sprite2D.texture = normal_texture
