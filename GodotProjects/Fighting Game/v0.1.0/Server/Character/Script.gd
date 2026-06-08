extends CharacterBody2D
class_name Character

@export var Data: CharacterData

@export var InputVector: Vector2 = Vector2.ZERO

enum GroundStates {GROUNDED = 0, AIRBORNE = 1}
enum HitStates {FREE = 0, STUNNED = 1}
enum MovementStates {IDLE = 0, MOVING = 1}
enum WalkStates {WALKING, RUNNING, DASH}

@export var GroundState: GroundStates
@export var HitState: HitStates
@export var MovementState: MovementStates
@export var WalkState: WalkStates


func _ready() -> void:
	custom_character_ready()


func custom_character_ready() -> void:
	pass


func _process(delta: float) -> void:
	custom_character_process(delta)


func custom_character_process(delta: float) -> void:
	pass


func move(delta: float) -> void:
	if HitState == HitStates.FREE:
		match GroundState:
			GroundStates.GROUNDED:
				pass
			GroundStates.AIRBORNE:
				pass
	
