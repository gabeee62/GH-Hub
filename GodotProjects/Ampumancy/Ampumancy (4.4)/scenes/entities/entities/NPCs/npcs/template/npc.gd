extends Entity
class_name NPC

enum NPC_TYPES {BACKGROUND, DIALOGUE, VENDOR, }

@export var TYPE: NPC_TYPES

@export var interactable: bool


func custom_entity_ready() -> void:
	SignalBus.npc_interact.connect(on_interact)
	
	custom_npc_ready()


func custom_npc_ready() -> void:
	pass


func custom_entity_process(delta: float) -> void:
	if interactable:
		$InteractBox.monitoring = true
	else:
		$InteractBox.monitoring = false
	
	custom_npc_process(delta)


func custom_npc_process(delta: float) -> void:
	pass


func on_interact() -> void:
	pass
