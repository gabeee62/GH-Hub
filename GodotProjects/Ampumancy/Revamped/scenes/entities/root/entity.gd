extends CharacterBody2D
class_name Entity

@export var entity_data: EntityData


func _process(delta: float) -> void:
	#gravity(delta)
	
	custom_entity_process(delta)


func custom_entity_process(delta: float) -> void:
	pass
