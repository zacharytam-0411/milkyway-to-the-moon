extends Area2D

@export var dps = 9000
@onready var rock: Sprite2D = $Sprite2D


func _process(delta):
	rotation_degrees += deg_to_rad(dps) * delta
	if Global.rock > 100:
		rock.texture = preload("res://assets/iron.png")
		Global.rock1mult = 1+((Global.rock-100)*0.05)


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Global._rock_1click()
