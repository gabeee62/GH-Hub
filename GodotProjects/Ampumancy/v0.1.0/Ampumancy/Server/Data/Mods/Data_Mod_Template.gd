extends Resource
class_name ModData

@export var Name: String
@export var Description: String

var Database: DirAccess = DirAccess.open("user://Mods/")
var common: String = "../Common"
var server: String = "../Server"
