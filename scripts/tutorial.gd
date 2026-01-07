extends Node2D

@onready var overlay: TextureRect = $CanvasLayer/TextureRect
@onready var panel: Panel = $CanvasLayer/Panel
@onready var text_label: Label = $CanvasLayer/Panel/Label
@onready var continue_label: Label = $CanvasLayer/Panel/ContinueLabel

var dialogue_lines = [
	"Welcome to the game!",
	"This is a test tutorial.",
	"You can press the space bar to skip the typing or go to the next line.",
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
	overlay.visible = false
	panel.visible = false
	_hide_continue_prompt()
	Global.emit_signal("earth_0")
	get_tree().change_scene_to_file("res://scenes/s1.tscn")
