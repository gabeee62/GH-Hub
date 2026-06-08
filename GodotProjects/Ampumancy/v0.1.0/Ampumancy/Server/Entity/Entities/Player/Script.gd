@tool
extends Entity
class_name Player

# FIXME: Set up the stuff for the new sprite

@export var Data: PlayerData

var WASDVector: Vector2 = Vector2.ZERO


func _ready() -> void:
	Data = Globals.CurrentSave.Player_Data # Must be first to allow the player to calculate any variables on ready (see the jump variables below)
	
	Data.JumpVelocity = ((2.0 * Data.JumpHeight) / Data.TimeToPeak) * -1.0
	Data.JumpGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToPeak * Data.TimeToPeak)) * -1.0
	Data.FallGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToLand * Data.TimeToLand)) * -1.0
	
	Globals.CurrentPlayer = self # This is put last to ensure no outside elements can access or manipulate player data before the player is ready


func custom_entity_tool_process() -> void:
	pass


func custom_entity_game_process(delta: float) -> void: # All of the in-game processes for the player that run every frame.
	flip_player()
	update_data()
	movement(delta)


func update_data() -> void:
	if Globals.CurrentSave.Player_Data != Data:
		Globals.CurrentSave.Player_Data = Data


func movement(delta: float) -> void:
	move(delta)
	
	move_and_slide()


func ground_detection() -> PlayerData.GroundStates:
	Data.GroundState = Data.GroundStates.GROUNDED if is_on_floor() else Data.GroundStates.AIRBORNE
	return Data.GroundState


func move(delta: float) -> void:
	if not Data.ControlLocked:
		match ground_detection():
			Data.GroundStates.GROUNDED:
				speed_control(Data.MoveSpeed, Data.Acceleration, Data.Deceleration)
				Data.CurrentDoubleJumps = Data.MaxDoubleJumps
				Data.FastFalling = false
			Data.GroundStates.AIRBORNE:
				speed_control(Data.AirSpeed, Data.AirAcceleration, Data.AirDeceleration)
		buffer_jump()
	
	velocity.y += gravity() * delta


func speed_control(speed: float, accel: float, decel: float) -> void:
	var AccelDecel: float = accel if WASDVector.x != 0 else decel
	velocity.x = velocity.move_toward(WASDVector * speed, AccelDecel).x


func jump() -> void:
	if is_on_floor():
		velocity.y = Data.JumpVelocity
		Data.FastFalling = false
	elif Data.CurrentDoubleJumps > 0:
		velocity.y = Data.JumpVelocity
		Data.FastFalling = false
		Data.CurrentDoubleJumps -= 1
	else:
		$Nodes/JumpBufferTimer.start()


func buffer_jump() -> void:
	if Data.GroundState == Data.GroundStates.GROUNDED and $Nodes/JumpBufferTimer.time_left > 0.0:
		velocity.y = Data.JumpVelocity


func gravity() -> float:
	if velocity.y < 0:
		return Data.JumpGravity
	elif Data.FastFalling:
		return Data.FallGravity * (1 + Data.FastFallMultiplier)
	else:
		return Data.FallGravity


func update_tile_data() -> void:
	var EffectTiles: TileMapLayer = Globals.CurrentZone.EffectTiles
	var cell: Vector2i = EffectTiles.local_to_map(EffectTiles.to_local(global_position + Vector2(0, 1)))
	var tile: TileData = EffectTiles.get_cell_tile_data(cell)
	for effect in References.TileEffects:
		if tile.has_custom_data(effect):
			set_effect_tile_modifiers(effect, tile)


func set_effect_tile_modifiers(effect: String, tile: TileData) -> void:
	var tile_data: Variant = tile.get_custom_data(effect)
	match effect:
		"SaveGame":
			if tile_data:
				SaveHandler.save_game(Globals.CurrentSave)
		"KillPlayer":
			if tile_data:
				kill_player()
		"LockPlayer":
			Data.ControlLocked = true if data else false
		"Damage":
			if tile_data != 0:
				damage_player(tile_data)
		# TODO: Finish the effect terrain tiles and the functions for the data


func cast_spell(cast_with: StringName) -> void:
	var new_spell: Spell
	var origin: Marker2D
	match cast_with:
		"PLAYER_CAST_LEFT":
			match Data.Equipment.ActiveLeft:
				1:
					origin = $Sprite/Left_Arms/Primary/CastPoint
					new_spell = set_spell_parameters(Data.Equipment.PrimaryLeft.SpellID, origin, cast_with)
				-1:
					origin = $Sprite/Left_Arms/Secondary/CastPoint
					new_spell = set_spell_parameters(Data.Equipment.SecondaryLeft.SpellID, origin, cast_with)
		"PLAYER_CAST_RIGHT":
			match Data.Equipment.ActiveRight:
				1:
					origin = $Sprite/Right_Arms/Primary/CastPoint
					new_spell = set_spell_parameters(Data.Equipment.PrimaryRight.SpellID, origin, cast_with)
				-1:
					origin = $Sprite/Right_Arms/Secondary/CastPoint
					new_spell = set_spell_parameters(Data.Equipment.SecondaryRight.SpellID, origin, cast_with)
	if new_spell and has_enough_mana([new_spell.SolarCost, new_spell.MysticCost, new_spell.ManaCost]):
		origin.add_child(new_spell)
	else:
		new_spell.queue_free()


func has_enough_mana(mana_array: Array[int]) -> bool:
	for i: int in mana_array:
		if Data.Stats.SolarPoints >= mana_array[0]:
			if Data.Stats.MysticPoints >= mana_array[1]:
				if Data.Stats.ManaPoints >= mana_array[2]:
					Data.Stats.SolarPoints -= mana_array[0]
					Data.Stats.MysticPoints -= mana_array[1]
					Data.Stats.ManaPoints -= mana_array[2]
					return true
				else:
					return false
			else:
				return false
		else:
			return false
	return false


func set_spell_parameters(spell_id: int, origin: Marker2D, cast_with: StringName) -> Spell:
	var new_spell: Spell = SpellLibrary.get_spell(spell_id) # if SpellLibrary.SpellArray[spell_id].can_instantiate() else null
	new_spell.global_position = origin.global_position
	new_spell.Caster = self
	new_spell.CastWith = cast_with
	new_spell.Origin = origin
	return new_spell


func flip_player() -> void:
	if Data.LastFaced != track_mouse():
		Data.LastFaced = track_mouse()
		$Sprite.flip_player()


func damage_player(amount: int) -> void:
	while amount > 0:
		if amount * (1.0 - Data.Stats.GoldAbsorption) <= Data.Stats.GoldHealth:
			Data.Stats.GoldHealth -= amount * (1.0 - Data.Stats.GoldAbsorption)
			amount = 0
		else:
			amount -= Data.Stats.GoldHealth
			Data.Stats.GoldHealth = 0
		
		if amount > Data.Stats.Health:
			amount -= Data.Stats.Health
			Data.Stats.Health = 0
		else:
			Data.Stats.Health -= amount
			amount = 0


func kill_player() -> void:
	pass


func track_mouse() -> float:
	var mouse_pos: Vector2 = get_local_mouse_position()
	return Data.LastFaced if mouse_pos.x == 0.0 else mouse_pos.x / mouse_pos.abs().x
