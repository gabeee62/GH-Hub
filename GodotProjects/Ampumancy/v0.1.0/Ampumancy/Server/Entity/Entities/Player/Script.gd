@tool
extends Entity
class_name Player

@export var Data: PlayerData

var WASDVector: Vector2 = Vector2.ZERO


func _ready() -> void:
	Globals.CurrentPlayer = self
	Data.JumpVelocity = ((2.0 * Data.JumpHeight) / Data.TimeToPeak) * -1.0
	Data.JumpGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToPeak * Data.TimeToPeak)) * -1.0
	Data.FallGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToLand * Data.TimeToLand)) * -1.0


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process(delta)
	tool_process()


func tool_process() -> void:
	pass


func game_process(delta: float) -> void: # All of the in-game processes for the player that run every frame.
	flip_player()
	movement(delta)


func movement(delta: float) -> void:
	move(delta)
	
	move_and_slide()


func ground_detection() -> PlayerData.GroundStates:
	Data.GroundState = Data.GroundStates.GROUNDED if is_on_floor() else Data.GroundStates.AIRBORNE
	return Data.GroundState


func move(delta: float) -> void:
	match ground_detection():
		Data.GroundStates.GROUNDED:
			speed_control(Data.MoveSpeed, Data.Acceleration, Data.Deceleration)
			Data.CurrentDoubleJumps = Data.MaxDoubleJumps
			Data.FastFalling = false
		Data.GroundStates.AIRBORNE:
			speed_control(Data.AirSpeed, Data.AirAcceleration, Data.AirDeceleration)
	
	velocity.y += gravity() * delta
	buffer_jump()


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


func cast_spell(_origin: StringName) -> void:
	pass # TODO: Use match to do instantiation stuff


func flip_player() -> void:
	if Data.LastFaced != track_mouse():
		Data.LastFaced = track_mouse()
		$Sprite.flip_player()


func track_mouse() -> float:
	var mouse_pos: Vector2 = get_local_mouse_position()
	return Data.LastFaced if mouse_pos.x == 0.0 else mouse_pos.x / mouse_pos.abs().x
