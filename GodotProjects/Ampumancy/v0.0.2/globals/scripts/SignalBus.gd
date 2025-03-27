extends Node

signal player_ready()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Throwaway callables to prevent the warning produced by not directly using the signals in this script.
	player_ready.get_name()
