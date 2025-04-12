extends Spell

@export var DAMAGE: int

var wants_to_keep_casting: bool = true

var texture_dict: Dictionary = {
	-1.0: "res://media/graphics/spells/ice_flurry/ice_flurry_dart_l.png",
	1.0: "res://media/graphics/spells/ice_flurry/ice_flurry_dart_r.png"}


func custom_spell_process() -> void:
	$HandCastSprite.global_position = ORIGIN.global_position
	$Hitbox.rotation = deg_to_rad(90 * (1 - Globals.PLAYER.look_dir))
	$DartParticles.global_position = Globals.PLAYER.global_position
	$DartParticles.process_material.direction = Vector3(Globals.PLAYER.look_dir, 0, 0)
	$DartParticles.texture = load(texture_dict[Globals.PLAYER.look_dir])
	
	if ORIGIN.get_parent().name.begins_with("R"):
		if Input.is_action_pressed("CASTR"):
			wants_to_keep_casting = true
		else:
			wants_to_keep_casting = false
	if ORIGIN.get_parent().name.begins_with("L"):
		if Input.is_action_pressed("CASTL"):
			wants_to_keep_casting = true
		else:
			wants_to_keep_casting = false


func _on_mana_consume_timer_timeout() -> void:
	if Globals.PLAYER.consume_mana(1):
		if not wants_to_keep_casting:
			queue_free()
	else:
		queue_free()


func _on_initial_mana_consume_timer_timeout() -> void:
	if wants_to_keep_casting:
		$Timers/ManaConsumeTimer.start()
	else:
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.hit(DAMAGE)
