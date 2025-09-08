@tool
extends PlayerDetect
class_name GravityField

@export var GRAV_MOD: float = 1.0


func custom_process() -> void:
	if shape:
		$LeaveBox/CollisionShape2D.shape = shape


func trigger_action() -> void:
	Globals.PLAYER.GRAV_MOD = GRAV_MOD


func _on_leave_box_body_exited(body: Node2D) -> void:
	if body is Player:
		body.GRAV_MOD = Globals.MAIN.DATA.GRAV_MOD
