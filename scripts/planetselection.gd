extends Node2D

var unlock_screen = preload("res://scenes/unlock_ui.tscn")
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D
@onready var mercury: TextureButton = $Mercury
@onready var venus: TextureButton = $Venus
@onready var earth: TextureButton = $Earth
@onready var mars: TextureButton = $Mars
@onready var jupiter: TextureButton = $Jupiter


@onready var planet_buttons = {
	"mercury": $Mercury,
	"venus": $Venus,
	"earth": $Earth,
	"mars": $Mars,
	"jupiter": $Jupiter
}

var camera_tween: Tween

func _ready():
	Global.emit_signal("bgm_galaxy")

func _on_back_button_pressed() -> void:
	Sfxmanager.play_button_click()
	Global.emit_signal("main_theme")
	get_tree().change_scene_to_file("res://scenes/rocketlaunch.tscn")

func _on_mercury_pressed() -> void:
	if Global.mercury_unlocked:
		Global.emit_signal("bgm_mercury")
		await get_tree().create_timer(0.8).timeout
		anim.play("white_screen")
		await get_tree().create_timer(2).timeout
		Global.scene_from = "mercury"
		get_tree().change_scene_to_file("res://scenes/transition.tscn")
	else:
		pass

func _on_venus_pressed() -> void:
	if Global.venus_unlocked:
		Global.emit_signal("bgm_venus")
	else:
		pass
func _on_earth_pressed() -> void:
	if true:
		Global.emit_signal("bgm_earth")
		pass

func _on_mars_pressed() -> void:
	if Global.mars_unlocked:
		Global.emit_signal("bgm_mars")
	else:
		pass

func _on_jupiter_pressed() -> void:
	if Global.jupiter_unlocked:
		Global.emit_signal("bgm_jupiter")
	else:
		pass
