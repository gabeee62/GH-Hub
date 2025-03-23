extends Node2D
class_name Level

var DEFAULT_ZOOM: float = .6

var max_zoom: float = 3.0
var min_zoom: float = .5


func _ready():
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ZOOM_IN") and $Player/Camera2D.zoom.x < max_zoom:
		$Player/Camera2D.zoom += Vector2(.1, .1)
	if Input.is_action_just_pressed("ZOOM_OUT") and $Player/Camera2D.zoom.x > min_zoom:
		$Player/Camera2D.zoom -= Vector2(.1, .1)


func _on_player_shoot(body: Node2D) -> void:
	$Projectiles.add_child(body)


func _on_player_entered(zoom: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(zoom, zoom), .8)


func _on_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(DEFAULT_ZOOM, DEFAULT_ZOOM), .5)


func _on_seek(entity: Drone) -> void:
	entity.hunt_direction = $Player.global_position
