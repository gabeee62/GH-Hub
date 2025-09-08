@tool
extends Area2D
class_name HitBox

enum BEHAVIORS {CONSTANT, SINGLEFRAME, GROUPFRAME, MULTIFRAME, PROJECTILE, PROJFRAME, PROJGROUPFRAME, PROJMULTIFRAME}

@export var KBSTRENGTH: float
@export var KBVECTOR: Vector2
@export var DAMAGE: int
@export var SHAPE: Shape2D

@export var behavior: BEHAVIORS
@export var show_kb_guide: bool


func _process(delta: float) -> void:
	if show_kb_guide:
		$KnockBackGuide.show()
	else:
		$KnockBackGuide.hide()
	$CollisionShape2D.shape = SHAPE
	$KnockBackGuide.clear_points()
	$KnockBackGuide.add_point($KnockBackGuide.position)
	$KnockBackGuide.add_point(KBVECTOR.normalized() * KBSTRENGTH)
	
	if not Engine.is_editor_hint():
		$KnockBackGuide.hide()


func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(DAMAGE, KBVECTOR.normalized(), KBSTRENGTH)
