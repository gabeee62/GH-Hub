@tool
extends Control

@export var letter_scale: Vector2 = Vector2(1.0, 1.0)
@export var title_animations: Array[String] = ["TitleFloat", "TitleWave", "TitleWaveBounce", "TitleWaveFloat", "TitleWaveFloatBounce"]


func _ready() -> void:
	var num: int = RandomNumberGenerator.new().randi_range(0, len(title_animations) - 1)
	$Lettering/AnimationPlayer.play(title_animations[num])


func _process(_delta: float) -> void:
	if $Lettering.scale != letter_scale:
		$Lettering.scale = letter_scale
