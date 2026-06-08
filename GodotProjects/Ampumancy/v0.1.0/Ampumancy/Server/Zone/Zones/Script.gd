extends Node2D
class_name Zone

# TODO: Zone-specific autoloading of tilesets

@onready var EffectTiles: TileMapLayer = $Level/Effects

@export var Data: ZoneData
@export var FilePath: String = "res://Server/Zone/Zones/Zone_Template.tscn"


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GAME_PAUSE"):
		$PauseCanvas/PauseMenu.visible = not $PauseCanvas/PauseMenu.visible
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			Globals.PauseTick = Time.get_ticks_msec()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW, Vector2(0, 0))
		else:
			Globals.calculate_pausetime()
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			Input.set_custom_mouse_cursor(References.GameCursor, Input.CURSOR_ARROW, Vector2(8, 8))
	
	if event.is_action_pressed("TARGET_ENEMY"):
		var targetable_entities: Array[Entity]
		for entity: Entity in $Level/Entities.get_children():
			if entity != Globals.CurrentPlayer and entity != $Cameras/PlayerCamera.Target and entity.OnScreen:
				targetable_entities.append(entity)
		targetable_entities.sort_custom(closest_to_zero)
		if len(targetable_entities) > 0:
			$Cameras/PlayerCamera.set_target(targetable_entities[0])
	
	if event.is_action_pressed("CLEAR_TARGET"):
		$Cameras/PlayerCamera.clear_target()
	
	if event.is_action_pressed("LOCK_CAMERA"):
		$Cameras/PlayerCamera.lock_camera()


func _ready() -> void:
	Input.set_custom_mouse_cursor(References.GameCursor, Input.CURSOR_ARROW, Vector2(8, 8))
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Globals.CurrentZone = self
	Globals.CurrentSave.CurrentZone = FilePath
	Globals.StartTick = Time.get_ticks_msec()
	order_spawn()
	custom_ready() # DO NOT DELETE THIS EVER


func custom_ready() -> void:
	pass


func closest_to_zero(a: Entity, b: Entity) -> bool:
	var player_pos: Vector2 = Globals.CurrentPlayer.global_position
	var a_distance: Vector2 = (player_pos - a.global_position).abs()
	var b_distance: Vector2 = (player_pos - b.global_position).abs()
	if a_distance.x < b_distance.x:
		return true
	elif a_distance.x == b_distance.x:
		if a_distance.y <= b_distance.y:
			return true
		else:
			return false
	else:
		return false


func order_spawn() -> void:
	for i: PlayerSpawn in $FunctionNodes/PlayerSpawns.get_children():
		if i.name == Globals.CurrentSave.SpawnPoint:
			i.spawn_player()


func _on_player_spawned(player: Player) -> void:
	$Level/Entities.add_child(player)
	print("PLAYER SPAWNED")


func _on_spell_cast(spell: Spell) -> void:
	$Level/Spells.add_child(spell)
