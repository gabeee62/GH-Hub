extends PanelContainer

var player_ready: bool = false


func _ready() -> void:
	SignalBus.player_ready.connect(set_player_ready)


func set_player_ready() -> void:
	player_ready = not player_ready


func _process(_delta: float) -> void:
	if player_ready:
		update_all()


func update_all() -> void:
	update_normal_health()
	update_gold_health()


func update_normal_health() -> void:
	if $NormalHealth.value != Globals.PLAYER.DATA.STATS.HEALTH:
		get_tree().create_tween().tween_property($NormalHealth, "value", Globals.PLAYER.DATA.STATS.HEALTH, 0.4)


func update_gold_health() -> void:
	if $GoldHealth.value != Globals.PLAYER.DATA.STATS.GOLD_HEALTH:
		get_tree().create_tween().tween_property($GoldHealth, "value", Globals.PLAYER.DATA.STATS.GOLD_HEALTH, 0.4)
