extends Spell

@export var DAMAGE: int
@export var EXPLODE_DAMAGE: int
@export var MOVESPEED: float


func custom_spell_ready() -> void:
	$TransformBuffer/Fireball.global_position = ORIGIN.global_position
	$TransformBuffer/Fireball.VECTOR = (get_global_mouse_position() - ORIGIN.global_position).normalized()
	if get_global_mouse_position().x > Globals.PLAYER.global_position.x:
		$TransformBuffer/Fireball.get_child(-2)["parameters/blend_position"] = 1.0
	elif get_global_mouse_position().x < Globals.PLAYER.global_position.x:
		$TransformBuffer/Fireball.get_child(-2)["parameters/blend_position"] = -1.0


func custom_spell_process() -> void:
	pass


func _on_fireball_tree_exited() -> void:
	queue_free()
