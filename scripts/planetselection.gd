extends Node2D

var unlock_screen = preload("res://scenes/unlock_ui.tscn")

func _ready():
	Global.emit_signal("play_jupiter")
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rocketlaunch.tscn")



func _on_mercury_pressed() -> void:
	pass


func _on_venus_pressed() -> void:
	pass 

func _on_earth_pressed() -> void:
	pass
