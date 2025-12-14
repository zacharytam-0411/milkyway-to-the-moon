extends Area2D

@export var dps = 9000
@onready var rock: Sprite2D = $Sprite2D


func _process(delta):
	rotation_degrees += deg_to_rad(dps) * delta
	if Global.rock > 1000000:
		rock.texture = preload("res://assets/emerald.png")
	elif Global.rock > 100000:
		rock.texture = preload("res://assets/zinc.png")
	elif Global.rock > 10000:
		rock.texture = preload("res://assets/gold.png")
	elif Global.rock > 1000:
		rock.texture = preload("res://assets/iron.png")
	elif Global.rock > 100:
		rock.texture = preload("res://assets/copper.png")
	


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Global._rock_1click()
		if Global.rock > 1000000:
			Global.rock1mult += ((Global.rock-500000)*0.0009)
		elif Global.rock > 100000:
			Global.rock1mult += ((Global.rock-50000)*0.0007)
		elif Global.rock > 10000:
			Global.rock1mult += ((Global.rock-5000)*0.0005)
		elif Global.rock > 1000:
			Global.rock1mult += ((Global.rock-500)*0.0002)
		elif Global.rock > 100:
			Global.rock1mult += ((Global.rock-50)*0.0001)
		else:
			Global.rock1mult += ((Global.rock)*0.00005)
