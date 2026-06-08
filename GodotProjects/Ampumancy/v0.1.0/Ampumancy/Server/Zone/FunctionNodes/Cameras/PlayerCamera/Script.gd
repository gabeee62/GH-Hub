extends Camera2D

@onready var ScreenSize: Vector2 = get_viewport_rect().size

@export var Target: Entity

@export var x_clamp: float
@export var y_clamp: float

@export var CameraOffset: Vector2
var CameraPosition: Vector2
var CameraLocked: bool = false


func _process(_delta: float) -> void:
	if CameraLocked:
		global_position = Globals.CurrentPlayer.global_position + CameraOffset
	else:
		var target_pos: Vector2 = Target.global_position if Target != null and Target.OnScreen else get_global_mouse_position()
		CameraPosition = (target_pos - global_position) * 0.5
		CameraPosition.x = clamp(CameraPosition.x, ScreenSize.x / -x_clamp, ScreenSize.x / x_clamp)
		CameraPosition.y = clamp(CameraPosition.y, ScreenSize.y / -y_clamp, ScreenSize.y / y_clamp)
		global_position = Globals.CurrentPlayer.global_position + CameraPosition + CameraOffset


func lock_camera() -> void:
	CameraLocked = not CameraLocked
	if CameraLocked:
		clear_target()


func set_target(target: Entity) -> void:
	if not CameraLocked:
		Target = target


func clear_target() -> void:
	if Target != null:
		Target = null
