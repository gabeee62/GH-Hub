extends Node2D
class_name Spell

# If true, then the cast button can be
# held to repeatedly trigger the spell
# effect. Else, the player must press
# the cast button for each individual
# spell cast.
@export var hold_cast: bool

# If true, the arm that cast the spell 
# remains busy until the spell despawns,
# after which the cooldown timer starts.
# Else, the cooldown timer will begin when
# the player casts the spell.
@export var cooldown_on_death: bool


func _ready() -> void:
	if not cooldown_on_death:
		$Timers/CDTimer.start()
	
	custom_spell_ready()


func custom_spell_ready() -> void:
	pass


func _process(delta: float) -> void:
	if hold_cast:
		hold_to_cast()
	
	custom_spell_process(delta)


func custom_spell_process(delta: float) -> void:
	pass


func hold_to_cast() -> void:
	pass


func _on_cd_timer_timeout() -> void:
	queue_free()
