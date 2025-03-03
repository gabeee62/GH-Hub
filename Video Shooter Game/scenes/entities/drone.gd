extends CharacterBody2D
class_name Drone

signal seek(entity: Drone)

enum STATES{WANDER, HUNT}

var current_state: STATES = STATES.WANDER

var hunt_direction: Vector2
var wander_direction: Vector2

var wander_movespeed: int = 150
var hunt_movespeed: int = 325

func _process(delta: float) -> void:
	match current_state:
		STATES.WANDER:
			wander()
		STATES.HUNT:
			hunt()
	
	move_and_slide()


func wander():
	velocity = velocity.move_toward(wander_direction.normalized() * wander_movespeed, 50)
	look_at(global_position + velocity)


func hunt():
	seek.emit(self)
	look_at(hunt_direction)
	velocity = velocity.move_toward((hunt_direction - position).normalized() * hunt_movespeed, 15)


func damage():
	current_state = STATES.HUNT


func _on_player_detect_body_entered(body: Node2D) -> void:
	current_state = STATES.HUNT


func _on_wander_timer_timeout() -> void:
	wander_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	$WanderTimer.wait_time = randi_range(3, 7)
	$WanderTimer.start()
