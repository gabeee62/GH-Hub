extends Control

@onready var ActiveSlot: Texture2D = preload("res://Common/Textures/UI/HUD/Arms/ActiveArmSlot.png")
@onready var InactiveSlot: Texture2D = preload("res://Common/Textures/UI/HUD/Arms/InactiveArmSlot.png")


func _process(_delta: float) -> void:
	if Globals.CurrentPlayer:
		match Globals.CurrentPlayer.Data.Equipment.ActiveLeft:
			1:
				$MarginContainer/Panel/Arms/Left/Primary.texture = ActiveSlot
				$MarginContainer/Panel/Arms/Left/Secondary.texture = InactiveSlot
			-1:
				$MarginContainer/Panel/Arms/Left/Primary.texture = InactiveSlot
				$MarginContainer/Panel/Arms/Left/Secondary.texture = ActiveSlot
		match Globals.CurrentPlayer.Data.Equipment.ActiveRight:
			1:
				$MarginContainer/Panel/Arms/Right/Primary.texture = ActiveSlot
				$MarginContainer/Panel/Arms/Right/Secondary.texture = InactiveSlot
			-1:
				$MarginContainer/Panel/Arms/Right/Primary.texture = InactiveSlot
				$MarginContainer/Panel/Arms/Right/Secondary.texture = ActiveSlot
