extends Entity

var normal_texture: Texture2D = preload("res://media/graphics/entities/dummy/dummy.png")
var hovering_texture: Texture2D = preload("res://media/graphics/entities/dummy/dummy_hovering.png")


func _ready() -> void:
	$Labels/DamageMarker.text = ""


func on_hit(damage: int, kb_vector: Vector2, kb_strength: float) -> void:
	$AnimationPlayer.play("hit")
	$Labels/DamageMarker.play_hit(damage)


func _on_mouse_entered() -> void:
	$Sprite/Sprite2D.texture = hovering_texture


func _on_mouse_exited() -> void:
	$Sprite/Sprite2D.texture = normal_texture
