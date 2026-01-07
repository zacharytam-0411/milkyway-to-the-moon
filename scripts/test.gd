extends Node2D
@onready var label: Label = $Label
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	Global.play_bgm = true
	label.text = ("To the moon..?")
	Global.emit_signal("bgm_odyssey")
	
func _on_button_pressed() -> void:
	Global.play_bgm = true
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	Global.play_bgm = true
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_settings_pressed() -> void:
	Global.emit_signal("bgm_earth")
	Global.play_bgm = true
	get_tree().change_scene_to_file("res://scenes/SettingsMenu.tscn")
