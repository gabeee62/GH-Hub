@tool
extends Control

@export var mana_unlocked: int
@export var mana: int
@export var mystic: int
@export var solar: int

@export var empty_texture: Texture2D = preload("res://Common/Textures/UI/HUD/Mana/empty_mana_point.png")
@export var mana_texture: Texture2D = preload("res://Common/Textures/UI/HUD/Mana/mana_point.png")
@export var mystic_texture: Texture2D = preload("res://Common/Textures/UI/HUD/Mana/mystic_point.png")
@export var solar_texture: Texture2D = preload("res://Common/Textures/UI/HUD/Mana/solar_point.png")


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		game_process()
	tool_process()


func tool_process() -> void:
	var points: Array[int] = [mana_unlocked, mana, mystic, solar]
	var textures: Array[Texture2D] = [empty_texture, mana_texture, mystic_texture, solar_texture]
	var i: int = 0
	for point_type: Node in $ManaMargin.get_children():
		set_mana_points(point_type, points[i], textures[i])
		i += 1


func game_process() -> void:
	if Globals.CurrentPlayer.Data:
		mana_unlocked = Globals.CurrentPlayer.Data.Stats.MaxManaPoints
		mana = Globals.CurrentPlayer.Data.Stats.ManaPoints
		mystic = Globals.CurrentPlayer.Data.Stats.MysticPoints
		solar = Globals.CurrentPlayer.Data.Stats.SolarPoints


func set_mana_points(point_type: Node, amount: int, texture: Texture2D) -> void:
	var difference: int = amount - len(point_type.get_children())
	while difference > 0:
		var point: TextureRect = TextureRect.new()
		point.texture = texture
		point_type.add_child(point)
		difference -= 1
	while difference < 0:
		point_type.get_child(0).queue_free()
		difference += 1
