@tool
extends Entity
class_name Player

@onready var stats: PlayerData = PlayerData.new()
@onready var states: Array[bool] = [
	$AnimationTree["parameters/conditions/crouch"],
	$AnimationTree["parameters/conditions/idle"],
	$AnimationTree["parameters/conditions/walk"],
	$AnimationTree["parameters/conditions/run"],]

@export var my_char: int

var characters: Array[String] = [
	"res://scenes/entities/player/sprites/animals/birb.png",
	"res://scenes/entities/player/sprites/animals/black.png",
	"res://scenes/entities/player/sprites/animals/brown.png",
	"res://scenes/entities/player/sprites/animals/frog.png",
	"res://scenes/entities/player/sprites/animals/gold.png",
	"res://scenes/entities/player/sprites/animals/pig.png",
	"res://scenes/entities/player/sprites/animals/red.png",
	"res://scenes/entities/player/sprites/animals/sheep.png",
	"res://scenes/entities/player/sprites/animals/white.png"]

var movement_vector: Vector2
var running: bool = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	tool_process()
	
	if not Engine.is_editor_hint():
		game_process(delta)


func tool_process():
	$Sprite.texture = load(characters[my_char])


func game_process(_delta: float) -> void:
	movement_vector = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	update_character_animations()
	
	accelerate()
	
	move_and_slide()


func update_character_animations() -> void:
	if Input.is_action_pressed("LEFT"):
		$Sprite.flip_h = true
	elif Input.is_action_pressed("RIGHT"):
		$Sprite.flip_h = false
	
	if movement_vector == Vector2.ZERO:
		if Input.is_action_pressed("CROUCH"):
			$AnimationTree["parameters/conditions/crouch"] = true
			$AnimationTree["parameters/conditions/idle"] = false
			$AnimationTree["parameters/conditions/walk"] = false
			$AnimationTree["parameters/conditions/run"] = false
		else:
			$AnimationTree["parameters/conditions/crouch"] = false
			$AnimationTree["parameters/conditions/idle"] = true
			$AnimationTree["parameters/conditions/walk"] = false
			$AnimationTree["parameters/conditions/run"] = false
	elif Input.is_action_pressed("RUN"):
		$AnimationTree["parameters/conditions/crouch"] = false
		$AnimationTree["parameters/conditions/idle"] = false
		$AnimationTree["parameters/conditions/walk"] = false
		$AnimationTree["parameters/conditions/run"] = true
	else:
		$AnimationTree["parameters/conditions/crouch"] = false
		$AnimationTree["parameters/conditions/idle"] = false
		$AnimationTree["parameters/conditions/walk"] = true
		$AnimationTree["parameters/conditions/run"] = false


func accelerate() -> void:
	velocity = velocity.move_toward(movement_vector.normalized() * stats.walkspeed, stats.acceleration)


func _input(_event: InputEvent) -> void:
	pass
