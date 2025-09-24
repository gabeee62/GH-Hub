@tool
extends PlayerDetect
class_name PrintOnDetect

@export var print_msg: String


func action_triggered():
	print(print_msg)
