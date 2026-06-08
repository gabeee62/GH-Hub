extends Resource
class_name QuestStepData

enum StepType {OBTAIN, TALK, GOTO, }

@export var Description: String
@export var Type: StepType
@export var Completed: bool = false

@export_category("Obtain Variables")
@export var RequiredItems: Array[Item]

@export_category("Talk Variables")
@export var Character: StringName

@export_category("Go-To Variables")
