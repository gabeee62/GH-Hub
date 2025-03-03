extends Area2D

signal player_entered(zoom: float)
signal player_exited()

var inside_zoom: float = 0.8

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	player_entered.emit(inside_zoom)


func _on_body_exited(body: Node2D) -> void:
	player_exited.emit()
