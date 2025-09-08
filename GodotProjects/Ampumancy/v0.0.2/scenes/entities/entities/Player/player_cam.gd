extends Camera2D

var ssCount = 1


func _ready() -> void:
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	
	dir = DirAccess.open("user://screenshots")
	for file in dir.get_files():
		ssCount += 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SCREENSHOT"):
		screenshot()


func screenshot() -> void:
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://screenshots/ss" + str(ssCount) + ".png")
	ssCount += 1
