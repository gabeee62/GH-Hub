@tool
extends Button

# TODO: Make text yellow when mouse hovers over button

@export var ButtonText: String
@export var TextSettings: LabelSettings

@export var NormalTextColor: Color = "ffffff"
@export var HoveredTextColor: Color = "ffff00"
@export var PressedTextColor: Color = "808080"


func _process(_delta: float) -> void:
	if $Label.position.y < 0:
		$Label.position.y = 0
	if ButtonText != $Label.text:
		$Label.text = ButtonText
	if $Label.label_settings != TextSettings:
		$Label.label_settings = TextSettings


func _on_mouse_entered() -> void:
	$AnimationPlayer.play("MouseHoverPulse")
	$Label.self_modulate = HoveredTextColor


func _on_mouse_exited() -> void:
	$AnimationPlayer.stop()
	$Label.position.y -= 4
	$Label.self_modulate = NormalTextColor


func _on_button_down() -> void:
	$AnimationPlayer.stop()
	$Label.self_modulate = PressedTextColor
	$Label.position.y += 4


func _on_button_up() -> void:
	$Label.self_modulate = NormalTextColor
	$Label.position.y -= 4
