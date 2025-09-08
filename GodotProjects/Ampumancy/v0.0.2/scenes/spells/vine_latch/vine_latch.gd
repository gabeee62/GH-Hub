extends Spell

@onready var DETECT: Area2D = $TransformBuffer/TerrainDetect
@onready var VINE: Sprite2D = $TransformBuffer/VineSprite

@export var MOVESPEED: float

var DIRECTION: Vector2
var ANCHOR: Vector2

var COLLIDED: bool = false
var HOOKED: bool = false


func custom_spell_ready() -> void:
	DETECT.global_position = ORIGIN.global_position
	DIRECTION = Vector2(get_global_mouse_position() - ORIGIN.global_position).normalized()


func custom_spell_process(delta: float) -> void:
	if wants_to_keep_casting:
		if COLLIDED:
			if HOOKED:
				grapple_player(delta)
			else:
				retract_vine(delta)
		else:
			shoot_vine(delta)
	else:
		retract_vine(delta)
	$TransformBuffer/VineSprite.look_at(DETECT.global_position)
	$TransformBuffer/VineSprite.region_rect = Rect2(Vector2(0, 0), Vector2((DETECT.global_position.x - $TransformBuffer/VineSprite.global_position.x) / 2, 6))
	$TransformBuffer/VineSprite.global_position = ORIGIN.global_position



func shoot_vine(delta: float) -> void:
	$TransformBuffer/VineSprite.global_position = ORIGIN.global_position
	DETECT.global_position += DIRECTION * MOVESPEED * delta


func grapple_player(delta: float) -> void:
	pass


func retract_vine(delta: float) -> void:
	DETECT.reparent(self)
	DETECT = get_child(-1)
	DIRECTION = Vector2(ORIGIN.global_position - get_child(-1).global_position).normalized()
	MOVESPEED = 400


func _on_terrain_detect_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		var tile_data: TileData = body.get_cell_tile_data(body.local_to_map(body.to_local(DETECT.global_position)))
		if tile_data.get_custom_data("grappleable") == true:
			ANCHOR = DETECT.global_position
			HOOKED = true
			COLLIDED = true
		else:
			COLLIDED = true


func _on_free_timer_timeout() -> void:
	COLLIDED = true
