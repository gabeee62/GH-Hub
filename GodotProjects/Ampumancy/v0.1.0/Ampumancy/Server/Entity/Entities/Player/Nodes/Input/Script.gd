extends Node

@onready var Parent: Player = $"../.."

var LastXVelocity: float
var LastYVelocity: float


func _process(_delta: float) -> void:
	Parent.WASDVector = Input.get_vector("PLAYER_LEFT", "PLAYER_RIGHT", "PLAYER_UP", "PLAYER_DOWN")
	
	if LastXVelocity != Parent.velocity.x: # Detects the moment the player's x velocity changes
		# HACK: Do stuff here before the last velocity gets changed
		LastXVelocity = Parent.velocity.x
	
	if LastYVelocity != Parent.velocity.y:
		if LastYVelocity < 0 and Parent.velocity.y > 0:
			$"../FastFallTimer".start()
		LastYVelocity = Parent.velocity.y


func _input(event: InputEvent) -> void:
	if Globals.CurrentPlayer:
		if event.is_action_pressed("PLAYER_JUMP"):
			Parent.jump() # FIXME: Make jump height scale with how long jump is held (maybe use timer)
		
		if event.is_action_pressed("PLAYER_DOWN") and $"../FastFallTimer".time_left > 0.0:
			Parent.Data.FastFalling = true
			# TODO: Make fastfall animation
		
		if event.is_action_pressed("PLAYER_SWITCH_LEFT"):
			Parent.Data.Equipment.ActiveLeft *= -1
		
		if event.is_action_pressed("PLAYER_SWITCH_RIGHT"):
			Parent.Data.Equipment.ActiveRight *= -1
		
		if event.is_action_pressed("PLAYER_SWITCH_BOTH"):
			Parent.Data.Equipment.ActiveLeft *= -1
			Parent.Data.Equipment.ActiveRight *= -1
		
		if event.is_action_pressed("PLAYER_CAST_LEFT") and not Parent.Data.Equipment.LeftBusy:
			Parent.cast_spell("PLAYER_CAST_LEFT")
		
		if event.is_action_pressed("PLAYER_CAST_RIGHT") and not Parent.Data.Equipment.RightBusy:
			Parent.cast_spell("PLAYER_CAST_RIGHT")
