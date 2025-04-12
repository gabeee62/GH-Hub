extends Node2D
class_name Spell

var TEAM: Util.TEAMS
var ORIGIN: Marker2D

enum ISCD {DISABLED = 4, ENABLED = 0}

# This boolean should be enabled if the spell should make the arm
# that cast it busy (unable to cast again) while it is being cast.
@export var MAKEBUSY: bool
# This enum should be set to Y only if it is a MAKEBUSY spell and
# should allow casting partway through its cast, instead of when
# the spell ends.
@export var ISBUSYCD: ISCD = ISCD.DISABLED


func _ready() -> void:
	visible = true
	$Timers/CooldownTimer.process_mode = int(ISBUSYCD)
	if not MAKEBUSY:
		make_not_busy()
	custom_spell_ready()


func custom_spell_ready() -> void:
	pass


func _process(_delta: float) -> void:
	global_position = Globals.PLAYER.global_position
	
	custom_spell_process()


func custom_spell_process() -> void:
	pass


func make_busy() -> void:
	if ORIGIN.get_parent().name.begins_with("L"):
		Globals.PLAYER.LArmBusy = true
	elif ORIGIN.get_parent().name.begins_with("R"):
		Globals.PLAYER.RArmBusy = true


func make_not_busy() -> void:
	if ORIGIN.get_parent().name.begins_with("L"):
		Globals.PLAYER.LArmBusy = false
	elif ORIGIN.get_parent().name.begins_with("R"):
		Globals.PLAYER.RArmBusy = false


func _on_cooldown_timer_timeout() -> void:
	make_not_busy()


func _on_tree_exited() -> void:
	if MAKEBUSY and ISBUSYCD == ISCD.DISABLED:
		make_not_busy()
