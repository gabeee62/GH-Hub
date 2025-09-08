@tool
extends Label

@export var splash_text: Array[String]


func _ready() -> void:
	rand_splash_text()


func _process(_delta: float) -> void:
	pivot_offset = size / 2


func rand_splash_text() -> void:
	text = splash_text[randi_range(0, len(splash_text) - 1)]
