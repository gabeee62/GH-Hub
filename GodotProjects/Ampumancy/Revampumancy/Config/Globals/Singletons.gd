extends Node

var save: SaveData
var level: Level
var player: Player

var current_time: int
var start_time: int


func start_playtime_clock() -> void:
	# Starts the playtime clock for save timekeeping.
	# Can also be used to restart the clock in the event
	# of a mid-game save.
	var time := Time.get_ticks_msec()
	current_time = time
	start_time = time


func get_session_playtime() -> int:
	# Returns the playime as a millisecond difference 
	# between the start time and the current time.
	current_time = Time.get_ticks_msec()
	return current_time - start_time


func msec_to_time(msecs: int) -> String:
	# Returns the selected save's playtime as a
	# string describing playtime in hours, minutes,
	# and seconds.
	var hours: int
	var mins: int
	var secs: int
	var time_array: Array[int] = [hours, mins, secs]
	var msec_array: Array[int] = [3600000, 60000, 1000]
	for measure in time_array:
		var array := div_and_remainder(msecs, msec_array[time_array.find(measure)])
		measure = array[0]
		msecs = array[1]
	return digits(hours) + ":" + digits(mins) + ":" + digits(secs)


func div_and_remainder(numerator: int, denominator: int) -> Array[int]:
	# Returns the number of divisions that can be performed
	# by the denominator and numerator, as well as the remainder
	# of the division.
	var i: int = 0
	while numerator > denominator:
		numerator -= denominator
		i += 1
	return [i, numerator]


func digits(num: int) -> String:
	# Determines whether or not to append a "0" to a 
	# time integer string depending on how many digits it has.
	if len(str(num)) < 2:
		return "0" + str(num)
	else:
		return str(num)
