extends Spell

@export var DAMAGE: int


func custom_spell_ready() -> void:
	$TransformBuffer/GolemstoneBoulder.global_position = ORIGIN.global_position + (get_global_mouse_position() - ORIGIN.global_position).normalized() * 25
	$TransformBuffer/GolemstoneBoulder.linear_velocity = (get_global_mouse_position() - ORIGIN.global_position).normalized() * 500 + Vector2(Globals.PLAYER.velocity.x, clampf(Globals.PLAYER.velocity.y, 0, -200))
	$TransformBuffer/GolemstoneBoulder.angular_velocity *= Globals.PLAYER.look_dir
