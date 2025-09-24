@tool
extends PlayerDetect
class_name InteractBox


func trigger_action() -> void:
	SignalBus.npc_interact.emit(get_parent())
