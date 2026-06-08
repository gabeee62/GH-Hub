extends Node

@onready var Parent: Player = $".."


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	Parent.WASDVector = Input.get_vector("MOVE_UP", "MOVE_DOWN", "MOVE_LEFT", "MOVE_RIGHT")
	
	if Input.is_action_just_pressed("JUMP"):
		pass
		
	if Input.is_action_just_pressed("SWITCH_LEFT"):
		pass
	if Input.is_action_just_pressed("SWITCH_RIGHT"):
		pass
	if Input.is_action_just_pressed("SWITCH_BOTH"):
		pass
		
	if Input.is_action_just_pressed("CAST_LEFT"):
		pass
	if Input.is_action_just_pressed("CAST_RIGHT"):
		pass
	if Input.is_action_just_pressed("CAST_LEG"):
		pass
