extends ParallaxBackground

@onready var motion_array: Array[float] = [
	layer1_motion,
	layer2_motion,
	layer3_motion,
	layer4_motion,
	layer5_motion,
	layer6_motion]
var layer1_motion: float
var layer2_motion: float
var layer3_motion: float
var layer4_motion: float
var layer5_motion: float
var layer6_motion: float


func _process(delta: float) -> void:
	$"1".motion_offset.x += layer1_motion * delta
	$"2".motion_offset.x += layer2_motion * delta
	$"3".motion_offset.x += layer3_motion * delta
	$"4".motion_offset.x += layer4_motion * delta
	$"5".motion_offset.x += layer5_motion * delta
	$"6".motion_offset.x += layer6_motion * delta


func set_new_parallax_bg(index: int) -> void:
	for p_layer: ParallaxLayer in get_children():
		p_layer.get_child(0).texture = null
		p_layer.visible = false
		for texture: Texture2D in Refs.clouds[index][0]:
			if p_layer.name == texture.resource_path.get_basename().split()[-1]:
				p_layer.get_child(0).texture = load(texture.resource_path)
				p_layer.visible = true
	layer1_motion = Refs.clouds[index][1][0]
	layer2_motion = Refs.clouds[index][1][1]
	layer3_motion = Refs.clouds[index][1][2]
	layer4_motion = Refs.clouds[index][1][3]
	layer5_motion = Refs.clouds[index][1][4]
	layer6_motion = Refs.clouds[index][1][5]
