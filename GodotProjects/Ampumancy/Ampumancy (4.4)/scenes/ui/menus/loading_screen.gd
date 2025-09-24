extends Control


func _process(delta: float) -> void:
	$ParallaxBackground/ChibiLayer.motion_offset += Vector2(35, 35) * delta
