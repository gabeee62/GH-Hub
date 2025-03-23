extends CharacterBody2D
class_name Player

@onready var JUMPVEL: float = ((-2.0 * data.JUMP_HEIGHT) / data.TIME_TO_PEAK)
@onready var JUMPGRAV:  float = ((2.0 * data.JUMP_HEIGHT) / Util.power_of(data.TIME_TO_PEAK, 2))
@onready var FALLGRAV:  float = ((2.0 * data.JUMP_HEIGHT) / Util.power_of(data.TIME_TO_LAND, 2))

var data: PlayerData


func _ready():
	Global.PLAYER = self


func _process(_delta: float) -> void:
	controls()


func controls():
	var input_vector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	match Global.MAIN.level_data.game_type:
		Util.GAME_TYPES.PLATFORMER:
			platformer_controls(input_vector)
		Util.GAME_TYPES.TOPDOWN:
			top_down_controls(input_vector)
	
	move_and_slide()


func platformer_controls(input_vector: Vector2) -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
	if is_on_floor():
		# UPDATE SAVE FILE POSITION
		Global.SAVE.current_position = global_position
		
		# EXTRA JUMP REFRESH
		data.EXTRA_JUMPS = data.MAX_EXTRA_JUMPS
		
		# JUMP
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = JUMPVEL
		
		# GROUND MOVEMENT
		if input_vector == Vector2.ZERO:
			velocity.x = velocity.move_toward(Vector2.ZERO, data.DECELERATION).x
		else:
			# RUNNING
			if Input.is_action_pressed("RUN"):
				velocity.x = velocity.move_toward(data.RUNSPEED * input_vector, data.ACCELERATION).x
			# WALKING
			else:
				velocity.x = velocity.move_toward(data.WALKSPEED * input_vector, data.ACCELERATION).x
	else:
		# EXTRA JUMP(S)
		if Input.is_action_just_pressed("JUMP") and data.EXTRA_JUMPS > 0:
			velocity.y = JUMPVEL
			data.EXTRA_JUMPS -= 1
		# AIR MOVEMENT
		if input_vector == Vector2.ZERO:
			velocity.x = velocity.move_toward(Vector2.ZERO, data.AIR_DECELERATION).x
		else:
			velocity.x = velocity.move_toward(data.AIRSPEED * input_vector, data.AIR_ACCELERATION).x
	
	# GRAVITY
	if velocity.y < 0:
		velocity.y -= JUMPGRAV
	else:
		velocity.y -= FALLGRAV


func top_down_controls(input_vector: Vector2) -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	Global.SAVE.current_position = global_position
	if input_vector == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, data.TDDECEL)
	else:
		velocity = velocity.move_toward(data.TDWALKSPEED * input_vector, data.TDACCEL)
	
	look_at(get_global_mouse_position())
