extends Control

@export var player_inventory: Inventory


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inv"):
		visible = not visible


#func update_ui_slot(ui_slot: InvUISlot, item: Item):
#	ui_slot.update(item)
