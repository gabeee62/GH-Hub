extends Sprite2D

@export var type: Utility.OUTFIT_TYPES


func _ready() -> void:
	_on_label_text_updated("1")


func _on_label_text_updated(value: String) -> void:
	match type:
		Utility.OUTFIT_TYPES.HAT:
			texture = References.hat_outfit[int(value) - 1]
		Utility.OUTFIT_TYPES.HEAD:
			texture = References.head_outfit[int(value) - 1]
		Utility.OUTFIT_TYPES.EYES:
			texture = References.eyes_outfit[int(value) - 1]
		Utility.OUTFIT_TYPES.CLOAK:
			texture = References.cloak_outfit[int(value) - 1]
		Utility.OUTFIT_TYPES.BODY:
			texture = References.body_outfit[int(value) - 1]
