extends Node2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var target_planet: TextureRect = $TargetPlanet
@onready var target_planet_label: Label = $TargetPlanetLabel

func _ready() -> void:
	anim.play("change_planet")
	
	match Global.scene_from:
		"mercury":
			target_planet.set_texture(preload("res://assets/mercury.png"))
			target_planet_label.text = "WNG"
		"venus":
			target_planet.set_texture(preload("res://assets/venus.png"))
			target_planet_label.text = "PCR"
		"earth":
			target_planet.set_texture(preload("res://assets/earth.png"))
			target_planet_label.text = "TER"
		"mars":
			target_planet.set_texture(preload("res://assets/mars.png"))
			target_planet_label.text = "BWR"
		"jupiter":
			target_planet.set_texture(preload("res://assets/jupiter.png"))
			target_planet_label.text = "BJL"
		"saturn":
			target_planet.set_texture(preload("res://assets/saturn.png"))
			target_planet_label.text = "BOD"
		"uranus":
			target_planet.set_texture(preload("res://assets/uranus.png"))
			target_planet_label.text = "MGC"
		"neptune":
			target_planet.set_texture(preload("res://assets/neptune.png"))
			target_planet_label.text = "MST"
		_:
			target_planet.set_texture(preload("res://assets/sun.png"))
			target_planet_label.text = "SOL"
	
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_file("res://scenes/s1.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(0.5).timeout
	anim.play("change_planet")
