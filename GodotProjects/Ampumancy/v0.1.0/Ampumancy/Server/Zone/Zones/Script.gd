extends Node2D
class_name Zone

# TODO: Make pause menu
# TODO: Zone-specific autoloading of tilesets
# TODO: 

@export var Data: ZoneData
@export var Packed: PackedScene


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GAME_PAUSE"):
		get_tree().paused = not get_tree().paused
		$PauseCanvas/PauseMenu.visible = not $PauseCanvas/PauseMenu.visible


func _ready() -> void:
	Globals.CurrentZone = self
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
