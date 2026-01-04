extends CanvasLayer

var planet_name = " "
var text_color = Color.WHITE

func _ready():
	$Message.text = "Unlocked Planet: " + planet_name
	$Message.self_modulate = text_color
	get_tree().paused = true
	$Anim.play("ShowUnlock")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ShowUnlock":
		get_tree().paused = false
		queue_free()
