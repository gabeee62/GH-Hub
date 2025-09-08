@tool
extends Button
class_name LabelButton

@export var label_text: String
@export var label_settings: LabelSettings


func _ready() -> void:
	get_tree().paused = false


func _process(_delta: float) -> void:
	custom_minimum_size = $Label.size
	$Label.text = label_text
	$Label.label_settings = label_settings
	$Label.pivot_offset = $Label.size / 2


func _on_mouse_entered() -> void:
	$Label.label_settings.font_color = Color.YELLOW
	$AnimationPlayer.play("pulse")


func _on_mouse_exited() -> void:
	$Label.label_settings.font_color = Color.WHITE
	$AnimationPlayer.stop()


func _on_button_down() -> void:
	$Label.label_settings.font_color = Color.DARK_SLATE_GRAY
	$AnimationPlayer.stop()
	$Label.scale = Vector2(0.8, 0.8)


func _on_button_up() -> void:
	$Label.label_settings.font_color = Color.WHITE
	$Label.scale = Vector2(1.0, 1.0)
