extends Node2D
@onready var rocket_building: Button = $RocketBuilding




func _on_rocket_building_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rocket.tscn")
