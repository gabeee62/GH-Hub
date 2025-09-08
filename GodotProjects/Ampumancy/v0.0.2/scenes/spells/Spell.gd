extends Node2D
class_name Spell

var TEAM: Util.TEAMS
var ORIGIN: Marker2D

enum ISCD {DISABLED = 4, ENABLED = 0}

@export var HOLDTOCAST: bool
var wants_to_keep_casting: bool = true
# This boolean should be enabled if the spell should make the arm
# that cast it busy (unable to cast again) while it is being cast.
@export var MAKEBUSY: bool
# This enum should be set to Y only if it is a MAKEBUSY spell and
# should allow casting partway through its cast, instead of when
# the spell ends.
@export var ISBUSYCD: ISCD = ISCD.DISABLED


func _ready() -> void:
	$Timers/CooldownTimer.process_mode = ISBUSYCD as ProcessMode
	if not MAKEBUSY:
		make_not_busy()
	
	custom_spell_ready()
	
	visible = true


func custom_spell_ready() -> void:
	pass


func _process(delta: float) -> void:
	global_position = Globals.PLAYER.global_position
	
	hold_to_cast()
	
	custom_spell_process(delta)


func custom_spell_process(delta: float) -> void:
	pass


func hold_to_cast() -> void:
	if HOLDTOCAST:
		if ORIGIN.get_parent().name.begins_with("R"):
			if Input.is_action_pressed("CASTR"):
				wants_to_keep_casting = true
			else:
				wants_to_keep_casting = false
		if ORIGIN.get_parent().name.begins_with("L"):
			if Input.is_action_pressed("CASTL"):
				wants_to_keep_casting = true
			else:
				wants_to_keep_casting = false


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
