extends Node2D
class_name Level

var empty_point_scene: PackedScene = preload("res://scenes/ui/hud/empty_point.tscn")
var mana_point_scene: PackedScene = preload("res://scenes/ui/hud/mana_point.tscn")
var mystic_point_scene: PackedScene = preload("res://scenes/ui/hud/mystic_point.tscn")
var solar_point_scene: PackedScene = preload("res://scenes/ui/hud/solar_point.tscn")


func _ready() -> void:
	Global.main = self
	
	SignalBus.spell_cast.connect(_on_spell_cast)
	SignalBus.reparent_spell_particles.connect(_on_reparent_spell_particles)


func _process(_delta: float):
	# COORDINATES
	$Menus/HeadsUpDisplay.xcoord = $Player.xcoord
	$Menus/HeadsUpDisplay.ycoord = $Player.ycoord
	# CAMERA ZOOM
	if Input.is_action_just_pressed("zoom in"):
		$Player/PlayerCam.zoom += Vector2(.1, .1)
	if Input.is_action_just_pressed("zoom out"):
		$Player/PlayerCam.zoom -= Vector2(.1, .1)
	# PAUSE MENU
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		$Menus/InGameMenu.visible = not $Menus/InGameMenu.visible


func _on_player_regen_mana(num: int) -> void:
	while num > 0 and $Menus/HeadsUpDisplay/ManaPoints.get_child_count() < $Player.stats.max_mana_points and $Menus/HeadsUpDisplay/ManaPoints.get_child_count() < 16:
		$Menus/HeadsUpDisplay/ManaPoints.add_child(mana_point_scene.instantiate())
		num -= 1
	while num > 0 and $Menus/HeadsUpDisplay/MysticPoints.get_child_count() + 16 < $Player.stats.max_mana_points and $Menus/HeadsUpDisplay/MysticPoints.get_child_count() < 16:
		$Menus/HeadsUpDisplay/MysticPoints.add_child(mystic_point_scene.instantiate())
		num -= 1


func _on_spell_cast(spell: Spell) -> void:
	if spell != null:
		$Spells.call_deferred("add_child", spell)


func _on_reparent_spell_particles(particles: GPUParticles2D):
	particles.reparent($Spells/Particles)
