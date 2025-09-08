@tool
extends Area2D
class_name PlayerDetect

var player_collided: bool = false
var trigger_pulled: bool = false

@export var shape: Shape2D
@export var sleep_time: float = 1.0
@export var oneshot: bool
@export var button: String = "INTERACT"
@export var trigger: Util.DETECT_TRIGGERS


func custom_process() -> void:
	pass


func _process(_delta: float) -> void:
	$CollisionShape2D.shape = shape
	custom_process()
	if not Engine.is_editor_hint():
		match trigger:
			Util.DETECT_TRIGGERS.COLLIDE:
				collision()
			Util.DETECT_TRIGGERS.BUTTON:
				button_pressed()
			Util.DETECT_TRIGGERS.CONDITION:
				condition_met()


func trigger_action():
	pass


func collision():
	if player_collided and not trigger_pulled:
		if oneshot:
			trigger_action()
		else:
			trigger_action()
			$SleepTimer.start(sleep_time)
		trigger_pulled = true


func button_pressed():
	if Input.is_action_just_pressed(button) and player_collided:
		trigger_action()


func condition_met():
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_collided = true


func _on_body_exited(_body: Node2D) -> void:
	if player_collided:
		$SleepTimer.stop()
		trigger_pulled = false
		player_collided = false


func _on_sleep_timer_timeout() -> void:
	trigger_action()
