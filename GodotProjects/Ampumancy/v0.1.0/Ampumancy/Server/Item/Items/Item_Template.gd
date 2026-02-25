extends Resource
class_name Item

@export var name: String
@export var texture: Texture2D
@export var max_stack: int
@export var stack_size: int
@export var categories: Array[StringName]

@export var craftable: bool
@export var recipe: Array[Item]
@export var workspace_required: String = "None"
