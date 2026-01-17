extends Area2D

@export var dps = 9000
@onready var rock: Sprite2D = $Sprite2D
var cts: int = 0
var clicktime: float = 0.0

func _process(delta):
	rotation_degrees += dps * delta
	clicktime += delta
