extends Node2D
class_name Stage

var RoundTime: int = 0


func _ready() -> void:
	
	
	custom_stage_ready()


func custom_stage_ready() -> void:
	pass


func _process(delta: float) -> void:
	custom_stage_process(delta)


func custom_stage_process(delta: float) -> void:
	pass
