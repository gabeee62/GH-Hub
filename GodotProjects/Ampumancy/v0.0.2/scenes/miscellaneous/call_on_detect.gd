@tool
extends PlayerDetect
class_name CallOnDetect

@export var function_name: String
@onready var function: Callable = Callable(StructFuncs, function_name)


func trigger_action():
	function.call()
