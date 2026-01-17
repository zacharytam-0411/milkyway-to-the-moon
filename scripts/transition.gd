extends Node2D

func _ready() -> void:
	if Global.scene_from == "mercury":
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file("res://scenes/s1.tscn")
	else:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/s1.tscn")
