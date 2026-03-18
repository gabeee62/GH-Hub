extends Resource
class_name PlayerEquipmentData

@export_group("Arms")
@export var PrimaryLeft: ArmItem = preload("res://Server/Item/Items/Equipment/Arm/Arm_None.tres")
@export var PrimaryRight: ArmItem = preload("res://Server/Item/Items/Equipment/Arm/Arm_None.tres")
@export var SecondaryLeft: ArmItem = preload("res://Server/Item/Items/Equipment/Arm/Arm_None.tres")
@export var SecondaryRight: ArmItem = preload("res://Server/Item/Items/Equipment/Arm/Arm_None.tres")
@export_group("Legs")
@export var EquippedLegs: LegsItem = preload("res://Server/Item/Items/Equipment/Leg/Legs_None.tres")
@export_group("", "")

@export var ActiveLeft: int = 1
@export var ActiveRight: int = 1
