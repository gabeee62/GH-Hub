class_name Player extends Entity

var WASDVector: Vector2 = Vector2.ZERO

@export var Data: PlayerData


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	movement(delta)


func movement(delta: float) -> void:
	match Data.ground_state:
		Data.GroundStates.GROUNDED:
			pass
		Data.GroundStates.AIRBORNE:
			pass
	
	move_and_slide()
