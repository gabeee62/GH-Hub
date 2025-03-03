extends CharacterBody2D
class_name Player

signal shoot(body: Node2D)

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

var primary_cd: bool = true
var secondary_cd: bool = true

@export var movespeed: int


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	
	controls()


func controls():
	velocity = velocity.move_toward(Input.get_vector("LEFT", "RIGHT", "UP", "DOWN").normalized() * movespeed, 50)
	
	if Input.is_action_just_pressed("FLASHLIGHT"):
		$TorchLight.enabled = not $TorchLight.enabled
	
	if Input.is_action_pressed("PRIMARY") and primary_cd:
		primary_cd = false
		$PrimaryCD.start()
		$GPUParticles2D.emitting = true
		var laser: Area2D = laser_scene.instantiate()
		laser.position = $BarrelMarker.global_position
		shoot.emit(laser)
	if Input.is_action_just_pressed("SECONDARY") and secondary_cd:
		secondary_cd = false
		$SecondaryCD.start()
		var grenade: RigidBody2D = grenade_scene.instantiate()
		grenade.position = $BarrelMarker.global_position
		shoot.emit(grenade)
	
	look_at(get_global_mouse_position())
	
	move_and_slide()


func _on_primary_cd_timeout() -> void:
	primary_cd = true


func _on_secondary_cd_timeout() -> void:
	secondary_cd = true
