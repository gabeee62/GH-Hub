extends Area2D

var TEAM: Util.TEAMS
var DAMAGE: int = 30
var EXPLODE_DAMAGE: int = 50
var MOVESPEED: float = 750
var VECTOR: Vector2


func _ready() -> void:
	VECTOR = (get_global_mouse_position() - global_position).normalized()
	if get_global_mouse_position().x > Globals.PLAYER.global_position.x:
		$AnimationTree["parameters/blend_position"] = 1.0
	elif get_global_mouse_position().x < Globals.PLAYER.global_position.x:
		$AnimationTree["parameters/blend_position"] = -1.0


func _process(delta: float) -> void:
	position += VECTOR * MOVESPEED * delta


func explode() -> void:
	MOVESPEED = 0.0
	$AnimationTree.active = false
	$AnimationPlayer.play("explode")


func _on_death_timer_timeout() -> void:
	explode()


func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(DAMAGE)
	if body is not Player:
		explode()


func _on_explode_hitbox_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(EXPLODE_DAMAGE)
