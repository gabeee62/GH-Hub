extends StaticBody2D


func _ready() -> void:
	if randi_range(0, 1) == 1:
		$Lid.visible = false
