extends Node

signal save_chosen(save_name: String)
signal slot_freed(slot: PanelContainer)

signal level_ready()
signal player_ready()

signal npc_interact(npc: Entity)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Throwaway callables to prevent the warning produced by not directly using the signals in this script.
	save_chosen.get_name()
	level_ready.get_name()
	player_ready.get_name()
	slot_freed.get_name()
