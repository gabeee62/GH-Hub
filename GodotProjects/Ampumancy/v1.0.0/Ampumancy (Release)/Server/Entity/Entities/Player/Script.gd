extends Entity
class_name Player

var WASDVector: Vector2 = Vector2.ZERO

@export var Data: PlayerData = PlayerData.new()

@onready var JumpVelocity: float
@onready var JumpGravity: float
@onready var FallGravity: float


func _ready() -> void:
	#Data = Globals.CurrentSave.Player_Data # Must be first to allow the player to calculate any variables on ready (see the jump variables below)
	
	Data.JumpVelocity = ((2.0 * Data.JumpHeight) / Data.TimeToPeak) * -1.0
	Data.JumpGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToPeak * Data.TimeToPeak)) * -1.0
	Data.FallGravity = ((-2.0 * Data.JumpHeight) / (Data.TimeToLand * Data.TimeToLand)) * -1.0
	
	PlayerTracker.CurrentPlayer = self # This is put last to ensure no outside elements can access or manipulate player data before the player is ready


func _process(delta: float) -> void:
	movement(delta)


func movement(delta: float) -> void:
	match Data.GroundState:
		Data.GroundStates.GROUNDED:
			velocity.x = speed_control(Data.BaseMoveSpeed, Data.GroundAcceleration, Data.GroundFriction)
		Data.GroundStates.AIRBORNE:
			velocity.x = speed_control(Data.BaseAirSpeed, Data.AirAcceleration, Data.AirFriction)
	
	velocity.y += gravity() * delta
	
	move_and_slide()


func speed_control(speed: float, accel: float, friction: float) -> float:
	var AccelDecel: float = accel if WASDVector.x != 0 else friction
	return velocity.move_toward(WASDVector * speed, AccelDecel).x


func jump() -> void:
	if Data.GroundState == Data.GroundStates.GROUNDED:
		velocity.y = JumpVelocity
		Data.GroundState = Data.GroundStates.AIRBORNE


func gravity() -> float:
	return JumpGravity if velocity.y < 0.0 else FallGravity
