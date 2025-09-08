extends Sprite2D
class_name ArmSprite

@export var arm_index: int
var arm_data: ArmData


func _ready() -> void:
	set_arm_data()


func set_arm_data() -> void:
	var equipment: EquippedData = $"../../..".data.inventory.equipment
	var arms: Array[ArmData] = [equipment.LArm1, equipment.LArm2, equipment.RArm1, equipment.RArm2]
	arm_data = arms[arm_index]
