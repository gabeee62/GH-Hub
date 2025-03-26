extends PanelContainer

@onready var mana_pip: PackedScene = preload("res://scenes/ui/in-game/hud/mana_pip.tscn")
@onready var empty_mana_point: PackedScene = preload("res://scenes/ui/in-game/hud/empty_mana_point.tscn")
@onready var mana_point: PackedScene = preload("res://scenes/ui/in-game/hud/mana_point.tscn")
@onready var mystic_point: PackedScene = preload("res://scenes/ui/in-game/hud/mystic_point.tscn")
@onready var solar_point: PackedScene = preload("res://scenes/ui/in-game/hud/solar_point.tscn")

@onready var pips: GridContainer = $ManaPips
@onready var empty: GridContainer = $EmptyManaPoints
@onready var mana: GridContainer = $ManaPoints
@onready var mystic: GridContainer = $MysticPoints
@onready var solar: GridContainer = $SolarPoints

var player_ready: bool = false


func _ready() -> void:
	SignalBus.player_ready.connect(set_player_ready)


func set_player_ready():
	player_ready = not player_ready


func _process(_delta: float) -> void:
	if player_ready:
		update_all()


func update_all() -> void:
	update_pips()
	update_empty()
	update_mana()
	update_mystic()
	update_solar()


func update_pips() -> void:
	if len(pips.get_children()) < 16:
		var new_mana_pip: TextureRect = mana_pip.instantiate()
		pips.add_child(new_mana_pip)
	elif len(pips.get_children()) > 16:
		pips.get_child(-1).queue_free()


func update_empty() -> void:
	if len(empty.get_children()) < Globals.PLAYER.DATA.STATS.MAX_MANA:
		var new_empty_point: TextureRect = empty_mana_point.instantiate()
		empty.add_child(new_empty_point)
	elif len(empty.get_children()) > Globals.PLAYER.DATA.STATS.MAX_MANA:
		empty.get_child(-1).queue_free()


func update_mana() -> void:
	if len(mana.get_children()) < Globals.PLAYER.DATA.STATS.MANA:
		var new_mana_point: TextureRect = mana_point.instantiate()
		mana.add_child(new_mana_point)
	elif len(mana.get_children()) > Globals.PLAYER.DATA.STATS.MANA:
		mana.get_child(-1).queue_free()


func update_mystic() -> void:
	if len(mystic.get_children()) < Globals.PLAYER.DATA.STATS.MYSTIC:
		var new_mystic_point: TextureRect = mystic_point.instantiate()
		mystic.add_child(new_mystic_point)
	elif len(mystic.get_children()) > Globals.PLAYER.DATA.STATS.MYSTIC:
		mystic.get_child(-1).queue_free()


func update_solar() -> void:
	if len(solar.get_children()) < Globals.PLAYER.DATA.STATS.SOLAR:
		var new_solar_point: TextureRect = solar_point.instantiate()
		solar.add_child(new_solar_point)
	elif len(solar.get_children()) > Globals.PLAYER.DATA.STATS.SOLAR:
		solar.get_child(-1).queue_free()
