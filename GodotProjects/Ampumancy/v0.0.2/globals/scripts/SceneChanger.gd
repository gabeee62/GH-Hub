extends Node

var next_scene_path: String


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func change_scene(scene_path: String) -> void:
	next_scene_path = scene_path
	$CanvasLayer/AnimationPlayer.play("fade_out")


func fade_in() -> void:
	$CanvasLayer/AnimationPlayer.play("fade_in")


func load_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
