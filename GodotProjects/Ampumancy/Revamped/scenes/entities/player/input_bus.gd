extends Node

signal left_arm_switched()
signal right_arm_switched()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("JUMP"):
		get_parent().jump()
	if event.is_action_pressed("LMB"):
		get_parent().cast_spell($"../Sprite/RArms".active_arm)
	if event.is_action_pressed("RMB"):
		get_parent().cast_spell($"../Sprite/LArms".active_arm)
	# Sends signals to the two arm group nodes (LArms and RArms) to trigger
	# the respective group node's arm switch function
	if event.is_action_pressed("SWITCHL"):
		left_arm_switched.emit()
	if event.is_action_pressed("SWITCHR"):
		right_arm_switched.emit()
