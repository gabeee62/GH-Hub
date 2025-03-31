@tool
extends Area2D
class_name PlayerDetect

var player_collided: bool = false
var trigger_pulled: bool = false

@export var shape: Shape2D
@export var oneshot: bool
@export var button: String = "INTERACT"
@export var trigger: Util.DETECT_TRIGGERS

func _process(_delta: float) -> void:
	$CollisionShape2D.shape = shape
	
	if not Engine.is_editor_hint():
		match trigger:
			Util.DETECT_TRIGGERS.COLLIDE:
				if player_collided:
					trigger_pull()
			Util.DETECT_TRIGGERS.BUTTON:
				if Input.is_action_just_pressed(button) and player_collided:
					trigger_pull()
			Util.DETECT_TRIGGERS.CONDITION:
				pass


func action_triggered():
	pass


func trigger_pull():
	if oneshot and not trigger_pulled:
		trigger_pulled = true
		action_triggered()
	elif not trigger_pulled:
		trigger_pulled = true
		$SleepTimer.start()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_collided = true


func _on_body_exited(_body: Node2D) -> void:
	if player_collided:
		$SleepTimer.stop()
		trigger_pulled = false
		player_collided = false


func _on_sleep_timer_timeout() -> void:
	action_triggered()
