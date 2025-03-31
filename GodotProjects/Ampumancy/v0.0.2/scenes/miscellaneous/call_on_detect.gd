@tool
extends PlayerDetect

@export var function_name: String
@onready var function: Callable = Callable(Util, function_name)


func action_triggered():
	function.call()
