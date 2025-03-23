extends Node

var queued_file_path: String


func _ready() -> void:
	SignalBus.change_scene.connect(_on_change_scene)


func _on_change_scene(filepath: String, transition: Util.SCENE_CHANGE_TYPES, save: bool):
	# Sets the filepath to be used by the scene transition to the specified filepath
	queued_file_path = filepath
	
	# Only saves save data to disk if a level is loaded and is instructed to save.
	# FIXME: Add save bool to any broken static scene transitions
	if Global.MAIN and save:
		SaveHandler.save_to_disk()
	# Transitions to the level found at the specified filepath via the specified transition animation
	match transition:
		Util.SCENE_CHANGE_TYPES.FW:
			$AnimationPlayer.play("WHITE_FADE")
		Util.SCENE_CHANGE_TYPES.FB:
			$AnimationPlayer.play("BLACK_FADE")


# CALLED BY THE SCENE TRANSITION -- DO NOT CALL
func load_scene():
	get_tree().change_scene_to_file(queued_file_path)
