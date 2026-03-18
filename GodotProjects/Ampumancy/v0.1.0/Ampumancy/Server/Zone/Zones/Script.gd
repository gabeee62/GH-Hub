extends Node2D
class_name Zone

# TODO: Make pause menu
# TODO: Zone-specific autoloading of tilesets
# TODO: 

@export var Data: ZoneData
@export var FilePath: String = "res://Server/Zone/Zones/Zone_Template.tscn"


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GAME_PAUSE"):
		$PauseCanvas/PauseMenu.visible = not $PauseCanvas/PauseMenu.visible
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			Globals.PauseTick = Time.get_ticks_msec()
		else:
			Globals.calculate_pausetime()


func _ready() -> void:
	Globals.CurrentZone = self
	Globals.CurrentSave.CurrentZone = FilePath
	Globals.StartTick = Time.get_ticks_msec()
	order_spawn()
	custom_ready() # DO NOT DELETE THIS EVER


func custom_ready() -> void:
	pass


func order_spawn() -> void:
	for i: PlayerSpawn in $FunctionNodes/PlayerSpawns.get_children():
		if i.name == Globals.CurrentSave.SpawnPoint:
			i.spawn_player()


func _on_player_spawned(player: Player) -> void:
	$Level/Entities.add_child(player)
	print("PLAYER SPAWNED")
