@tool
extends PlayerDetect
class_name FogOfWar

@export var fog_color: Color
@export var clear_color: Color


func custom_process() -> void:
	if shape:
		$ColorRect.size = shape.get_rect().size
	$CollisionShape2D.position = Vector2.ZERO + ($ColorRect.size / 2)


func trigger_action() -> void:
	get_tree().create_tween().tween_property($ColorRect, "color", clear_color, 0.75)
