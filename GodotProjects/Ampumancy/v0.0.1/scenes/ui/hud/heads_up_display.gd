extends Control

var empty_point_scene: PackedScene = preload("res://scenes/ui/hud/empty_point.tscn")
var mana_point_scene: PackedScene = preload("res://scenes/ui/hud/mana_point.tscn")
var mystic_point_scene: PackedScene = preload("res://scenes/ui/hud/mystic_point.tscn")
var solar_point_scene: PackedScene = preload("res://scenes/ui/hud/solar_point.tscn")

var active_arm_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/active_arm_frame.png")
var inactive_arm_frame: Texture2D = preload("res://media/graphics/ui/hud/arms/inactive_arm_frame.png")

var xcoord: int
var ycoord: int

var gold_health: int
var health: int


func _process(delta: float) -> void:
	update_coords()


func update_coords() -> void:
	$XYCoords.text = "x: " + str(xcoord) + " y: " + str(ycoord)


func _on_player_finished(max_health: int, health: int, max_gold_health: int, gold_health: int, max_mana_points: int, mana_points: int, mystic_points: int) -> void:
	$GoldHealthBar/Label.text = str(gold_health + health) + ' / ' + str(max_gold_health + max_health)
	$GoldHealthBar.value = gold_health
	$HealthBar.value = health
	while $EmptyPoints.get_child_count() < max_mana_points:
		$EmptyPoints.add_child(empty_point_scene.instantiate())
	while $ManaPoints.get_child_count() < mana_points:
		$ManaPoints.add_child(mana_point_scene.instantiate())
	while $MysticPoints.get_child_count() < mystic_points:
		$MysticPoints.add_child(mystic_point_scene.instantiate())


func _on_player_update_health(current_health: int, current_gold_health: int, max_health: int, max_gold_health: int) -> void:
	$GoldHealthBar/Label.text = str(current_gold_health + current_health) + ' / ' + str(max_gold_health + max_health)
	
	var tween = get_tree().create_tween()
	tween.tween_property($GoldHealthBar, "value", current_gold_health, 0.2)
	tween.tween_property($HealthBar, "value", current_health, 0.2)


func _on_player_update_mana(mana_points: int, mystic_points: int) -> void:
	for i in $ManaPoints.get_children():
		i.queue_free()
	for i in range(0, mana_points):
		$ManaPoints.add_child(mana_point_scene.instantiate())
	for i in $MysticPoints.get_children():
		i.queue_free()
	for i in range(0, mystic_points):
		$MysticPoints.add_child(mystic_point_scene.instantiate())


func _on_player_switch_l() -> void:
	var arm_1_texture: Texture2D = $ArmsPanel/ArmsUI/LArms/LArm1/FrameUI.texture
	$ArmsPanel/ArmsUI/LArms/LArm1/FrameUI.texture = $ArmsPanel/ArmsUI/LArms/LArm2/FrameUI.texture
	$ArmsPanel/ArmsUI/LArms/LArm2/FrameUI.texture = arm_1_texture


func _on_player_switch_r() -> void:
	var arm_1_texture: Texture2D = $ArmsPanel/ArmsUI/RArms/RArm1/FrameUI.texture
	$ArmsPanel/ArmsUI/RArms/RArm1/FrameUI.texture = $ArmsPanel/ArmsUI/RArms/RArm2/FrameUI.texture
	$ArmsPanel/ArmsUI/RArms/RArm2/FrameUI.texture = arm_1_texture
