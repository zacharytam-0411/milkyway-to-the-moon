extends Node2D

@onready var overlay: TextureRect = $CanvasLayer/TextureRect
@onready var panel: Panel = $CanvasLayer/Panel
@onready var text_label: Label = $CanvasLayer/Panel/Label
@onready var continue_label: Label = $CanvasLayer/Panel/ContinueLabel
@onready var earth: TextureRect = $CanvasLayer/Planets/Earth
@onready var venus: TextureRect = $CanvasLayer/Planets/Venus
@onready var mercury: TextureRect = $CanvasLayer/Planets/Mercury
@onready var jupiter: TextureRect = $CanvasLayer/Planets/Jupiter
@onready var mars: TextureRect = $CanvasLayer/Planets/Mars
@onready var rock_2: Area2D = $CanvasLayer/Rock2
@onready var rock: TextureRect = $CanvasLayer/Rock
@onready var ironingot: TextureRect = $CanvasLayer/ironingot
@onready var goldingot: TextureRect = $CanvasLayer/goldingot
@onready var ironore: Area2D = $CanvasLayer/Ironore
@onready var goldore: Area2D = $CanvasLayer/Goldore
@onready var gold_4: TextureRect = $CanvasLayer/UpgradePart/Gold4
@onready var gold_3: TextureRect = $CanvasLayer/UpgradePart/Gold3
@onready var gold_2: TextureRect = $CanvasLayer/UpgradePart/Gold2
@onready var gold_1: TextureRect = $CanvasLayer/UpgradePart/Gold1
@onready var iron_3: TextureRect = $CanvasLayer/UpgradePart/Iron3
@onready var iron_2: TextureRect = $CanvasLayer/UpgradePart/Iron2
@onready var iron_1: TextureRect = $CanvasLayer/UpgradePart/Iron1
@onready var copper_2: TextureRect = $CanvasLayer/UpgradePart/Copper2
@onready var copper_1: TextureRect = $CanvasLayer/UpgradePart/Copper1
@onready var part_1: TextureRect = $CanvasLayer/UpgradePart/Part1
@onready var upgrade_part: AnimationPlayer = $CanvasLayer/UpgradePart/AnimationPlayer


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
	"The tutorial is now ending."
]

var current_line = 0
var typing = false
var typing_speed := 0.03
var blink_tween: Tween
var typing_tween: Tween

func _ready() -> void:
	overlay.visible = false
	panel.visible = false
	text_label.text = ""
	continue_label.visible = false
	earth.visible = false
	venus.visible = false
	mercury.visible = false
	mars.visible = false
	jupiter.visible = false
	rock_2.visible = false
	goldingot.visible = false
	ironingot.visible = false
	rock.visible = false
	ironore.visible = false
	goldore.visible = false
	gold_1.visible = false
	gold_2.visible = false
	gold_3.visible = false
	gold_4.visible = false
	iron_1.visible = false
	iron_2.visible = false
	iron_3.visible = false
	copper_1.visible = false
	copper_2.visible = false
	part_1.visible = false
	
	
	start_dialogue()

func start_dialogue():
	overlay.visible = true
	panel.visible = true
	text_label.visible = true
	text_label.text = ""
	current_line = 0
	_show_line()

func _show_line():
	if current_line < dialogue_lines.size():
		typing = true
		text_label.text = ""
		_hide_continue_prompt()
		
		if typing_tween:
			typing_tween.kill()
		
		_type_text(dialogue_lines[current_line])
		
	else:
		_end_dialogue()
	if current_line == 5:
		earth.visible = true
		venus.visible = true
		mercury.visible = true
		mars.visible = true
		jupiter.visible = true
	elif current_line == 6:
		rock_2.visible = true
		earth.visible = false
		venus.visible = false
		mercury.visible = false
		mars.visible = false
		jupiter.visible = false
	elif current_line == 7:
		goldore.visible = true
		ironore.visible = true
		goldingot.visible = true
		ironingot.visible = true
		rock.visible = true
	elif current_line == 8:
		rock_2.visible = false
		goldingot.visible = false
		ironingot.visible = false
		rock.visible = false
		goldore.visible = false
		ironore.visible = false
		gold_1.visible = true
		gold_2.visible = true
		gold_3.visible = true
		gold_4.visible = true
		iron_1.visible = true
		iron_2.visible = true
		iron_3.visible = true
		copper_1.visible = true
		copper_2.visible = true
		part_1.visible = true
		upgrade_part.play("upgrade_part")
	elif current_line == 9:
		gold_1.visible = false
		gold_2.visible = false
		gold_3.visible = false
		gold_4.visible = false
		iron_1.visible = false
		iron_2.visible = false
		iron_3.visible = false
		copper_1.visible = false
		copper_2.visible = false
		part_1.visible = false
	else:
		pass

func _type_text(line: String) -> void:
	if line.is_empty():
		_finish_typing()
		return
		
	typing_tween = create_tween()
	for i in range(line.length() + 1):
		typing_tween.tween_callback(func(): text_label.text = line.substr(0, i))
		typing_tween.tween_interval(typing_speed)
	
	typing_tween.tween_callback(_finish_typing)

func _finish_typing():
	typing = false
	_show_continue_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"): 
		if typing:
			if typing_tween:
				typing_tween.kill()
			text_label.text = dialogue_lines[current_line]
			_finish_typing()
		else:
			current_line += 1
			_show_line()

func _show_continue_prompt():
	continue_label.visible = true
	if blink_tween:
		blink_tween.kill()
	blink_tween = create_tween().set_loops()
	blink_tween.tween_property(continue_label, "modulate:a", 0.2, 0.75)
	blink_tween.tween_property(continue_label, "modulate:a", 1.0, 0.75)

func _hide_continue_prompt():
	continue_label.visible = false
	if blink_tween:
		blink_tween.kill()

func _end_dialogue():
	Global.tutorial_finished = true
	overlay.visible = false
	panel.visible = false
	_hide_continue_prompt()
	Global.emit_signal("main_theme")
	get_tree().change_scene_to_file("res://scenes/s1.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if current_line == 8:
		await get_tree().create_timer(0.3).timeout
		upgrade_part.play("upgrade_part")
	else:
		queue_free()
