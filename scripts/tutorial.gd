extends Node2D

@onready var overlay: TextureRect = $CanvasLayer/TextureRect
@onready var panel: Panel = $CanvasLayer/Panel
@onready var text_label: Label = $CanvasLayer/Panel/Label
@onready var continue_label: Label = $CanvasLayer/Panel/ContinueLabel
@onready var rock_2: Area2D = $CanvasLayer/Rock2
@onready var dino_2: AnimatedSprite2D = $CanvasLayer/TextureRect/AnimatedSprite2D2
@onready var dino: AnimatedSprite2D = $CanvasLayer/TextureRect/AnimatedSprite2D

@onready var planets = $CanvasLayer/Planets
@onready var mining_ui = $CanvasLayer/MiningStuff
@onready var upgrade_ui = $CanvasLayer/UpgradePart1
@onready var upgrade_ui_2: Node2D = $CanvasLayer/UpgradePart2
@onready var upgrade_ui_3: Node2D = $CanvasLayer/UpgradePart3
@onready var upgrade_anim: AnimationPlayer = $CanvasLayer/UpgradePart1/AnimationPlayer
@onready var upgrade_anim_2: AnimationPlayer = $CanvasLayer/UpgradePart2/AnimationPlayer2
@onready var upgrade_anim_3: AnimationPlayer = $CanvasLayer/UpgradePart3/AnimationPlayer3
@onready var rocketplanet: Node2D = $CanvasLayer/Rocketplanet

var dialogue_lines = [
	"Welcome to the game!",
	"I am Kuro.",
	"I am trying to get to space!",
	"Before the game starts, this is a tutorial part to make sure you know how to play!",
	"You can press the space bar to skip the typing or go to the next line.",
	"This game is a space-themed clicker game!",
	"You get resources by clicking the spinning rock on the left of your screen.",
	"As you get more and more rocks, you can get more minerals!",
	"You can use the minerals obtained to upgrade rocket parts!",
	"With all the rocket parts upgraded to the same level, you can craft a rocket!",
	"With each tier of rocket you unlock, you can get to different planets! (WIP)",
	"The tutorial is now ending, good luck, and enjoy the game!"
]

var current_line: int = 0
var typing: bool = false
var typing_speed: float = 0.03
var typing_tween: Tween
var blink_tween: Tween


func _ready() -> void:
	overlay.hide()
	panel.hide()
	planets.hide()
	mining_ui.hide()
	upgrade_ui.hide()
	upgrade_ui_2.hide()
	upgrade_ui_3.hide()
	continue_label.hide()
	rock_2.hide()
	dino_2.hide()
	rocketplanet.hide()
	text_label.text = ""
	
	start_dialogue()

func start_dialogue() -> void:
	overlay.show()
	panel.show()
	current_line = 0
	_show_line()

func _show_line() -> void:
	if current_line >= dialogue_lines.size():
		_end_dialogue()
		return

	_update_visuals(current_line)
	
	typing = true
	_hide_continue_prompt()
	text_label.text = dialogue_lines[current_line]
	text_label.visible_ratio = 0.0
	
	if typing_tween: typing_tween.kill()
	typing_tween = create_tween()
	
	var duration = dialogue_lines[current_line].length() * typing_speed
	typing_tween.tween_property(text_label, "visible_ratio", 1.0, duration)
	typing_tween.finished.connect(_finish_typing)

func _update_visuals(line_index: int) -> void:
	match line_index:
		5:
			planets.show()
		6:
			planets.hide()
			rock_2.show()
		7:
			rock_2.hide()
			mining_ui.show()
		8:
			mining_ui.hide()
			upgrade_ui.show()
			upgrade_ui_2.show()
			upgrade_anim.play("upgrade_part")
			upgrade_anim_2.play("upgrade_engine")
		9:
			upgrade_ui.hide()
			upgrade_ui_2.hide()
			upgrade_ui_3.show()
			upgrade_anim_3.play("rocket_craft")
		10:
			upgrade_ui_3.hide()
			dino.hide()
			dino_2.show()
			rocketplanet.show()
		11:
			dino.hide()
			rocketplanet.hide()
			dino_2.hide()

func _finish_typing() -> void:
	typing = false
	_show_continue_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"): 
		if typing:
			if typing_tween: typing_tween.kill()
			text_label.visible_ratio = 1.0
			_finish_typing()
		else:
			current_line += 1
			_show_line()

func _show_continue_prompt() -> void:
	continue_label.show()
	if blink_tween: blink_tween.kill()
	blink_tween = create_tween().set_loops()
	blink_tween.tween_property(continue_label, "modulate:a", 0.1, 0.6)
	blink_tween.tween_property(continue_label, "modulate:a", 1.0, 0.6)

func _hide_continue_prompt() -> void:
	continue_label.hide()
	if blink_tween: blink_tween.kill()

func _end_dialogue() -> void:
	Global.tutorial_finished = true
	Global.emit_signal("main_theme")
	get_tree().change_scene_to_file("res://scenes/s1.tscn")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if current_line == 8:
		await get_tree().create_timer(0.5).timeout
		if current_line == 8:
			upgrade_anim.play("upgrade_part")


func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	if current_line == 8:
		await get_tree().create_timer(0.5).timeout
		if current_line == 8:
			upgrade_anim_2.play("upgrade_engine")


func _on_animation_player_3_animation_finished(anim_name: StringName) -> void:
	if current_line == 9:
		await get_tree().create_timer(0.5).timeout
		if current_line == 9:
			upgrade_anim_3.play("rocket_craft")
