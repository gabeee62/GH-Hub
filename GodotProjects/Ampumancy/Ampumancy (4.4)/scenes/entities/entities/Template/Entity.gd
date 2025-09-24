extends CharacterBody2D
class_name Entity

var look_dir: float = 1.0

@export var ROOTED: bool

@export var DATA: EntityData


func _ready() -> void:
	
	custom_entity_ready()


func custom_entity_ready() -> void:
	pass


func _process(delta: float) -> void:
	movement(delta)
	
	custom_entity_process(delta)


func custom_entity_process(delta: float) -> void:
	pass


# Entities can use the default movement state machine,
# or replace it with a custom one in their script.
func movement(delta: float) -> void:
	match DATA.MOTION_MODE:
		0:
			stationary()
		1:
			wander()
		2:
			hunt()
		3:
			rooted()


# Entities can either use the base movement functions, or replace
# them with functions specific to them in their script.
func wander() -> void:
	if $Timers/ChangeDirectionTimer.is_stopped():
		$Timers/ChangeDirectionTimer.start(randf_range(3.0, 7.0))
	velocity.x = look_dir * 150.0


func stationary() -> void:
	pass


func hunt() -> void:
	pass


func rooted() -> void:
	pass


func on_hit(_damage: int, kb_vector: Vector2, kb_strength: float) -> void:
	if not ROOTED:
		knockback(kb_vector, kb_strength)


func knockback(kb_vector: Vector2, kb_strength: float) -> void:
	velocity = kb_vector * kb_strength


func hit(damage: int, kb_vector: Vector2, kb_strength: float) -> void:
	on_hit(damage, kb_vector, kb_strength)
	if DATA.HEALTH > 0:
		pass
	elif DATA.HEALTH < 0:
		pass


func _on_change_direction_timer_timeout() -> void:
	look_dir *= -1.0
