extends Node


func _ready() -> void:
	SignalBus.game_error.connect(_on_game_error)


func _on_game_error(err_code: Util.ERR_CODES):
	var err_data: Dictionary = JSON.parse_string(FileAccess.open("res://data/errors/error_codes.json", FileAccess.READ).get_as_text())
	output_err_message(err_data[Util.ERR_CODES.keys()[err_code]]["MESSAGE"])


func output_err_message(message: String):
	print("ERROR: " + message + "\n")
