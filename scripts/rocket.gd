extends Node2D

@onready var back_button: Button = $BackButton
@onready var upgrade_plating_button: Button = $UpgradePlatingButton
@onready var upgrade_engine_button: Button = $UpgradeEngineButton
@onready var upgrade_fins_button: Button = $UpgradeFinsButton
@onready var upgrade_topcone_button: Button = $UpgradeTopConeButton
@onready var upgrade_tank_button: Button = $UpgradeTankButton
@onready var craft_button: Button = $CraftButton

@onready var plating_1: TextureRect = $Plating1
@onready var plating_2: TextureRect = $Plating2
@onready var fins_1: TextureRect = $Fins1
@onready var fins_2: TextureRect = $Fins2
@onready var engine_1: TextureRect = $Engine1
@onready var tank_1: TextureRect = $Tank1
@onready var tank_2: TextureRect = $Tank2
@onready var top_cone_1: TextureRect = $TopCone1
@onready var rocket: TextureRect = $Rocket

var rocket_parts = {
	"plating": {"costs":[{"copper":10},{"iron":15,"copper":10},{"gold":20,"iron":15},{"zinc":25,"gold":20},{"emerald":30,"zinc":25},{"lapis":35,"emerald":30},{"diamond":40,"lapis":35}]},
	"engine": {"costs":[{"copper":12},{"iron":18,"copper":12},{"gold":24,"iron":18},{"zinc":30,"gold":24},{"emerald":36,"zinc":30},{"lapis":42,"emerald":36},{"diamond":50,"lapis":42}]},
	"fins": {"costs":[{"copper":8},{"iron":12,"copper":8},{"gold":16,"iron":12},{"zinc":20,"gold":16},{"emerald":24,"zinc":20},{"lapis":28,"emerald":24},{"diamond":32,"lapis":28}]},
	"topcone": {"costs":[{"copper":14},{"iron":20,"copper":14},{"gold":26,"iron":20},{"zinc":32,"gold":26},{"emerald":38,"zinc":32},{"lapis":44,"emerald":38},{"diamond":50,"lapis":44}]},
	"tank": {"costs":[{"copper":16},{"iron":22,"copper":16},{"gold":28,"iron":22},{"zinc":34,"gold":28},{"emerald":40,"zinc":34},{"lapis":46,"emerald":40},{"diamond":52,"lapis":46}]}
}

var plating_textures = [
	preload("res://assets/steelplate.png"),
	preload("res://assets/copperplate.png"),
	preload("res://assets/ironplate.png"),
	preload("res://assets/goldplate.png"),
	preload("res://assets/zincplate.png"),
	preload("res://assets/emeraldplate.png"),
	preload("res://assets/lapisplate.png"),
	preload("res://assets/diamondplate.png")
]

var fins_textures = [
	preload("res://assets/steelfin.png"),
	preload("res://assets/copperfin.png"),
	preload("res://assets/ironfin.png"),
	preload("res://assets/goldfin.png"),
	preload("res://assets/zincfin.png"),
	preload("res://assets/emeraldfin.png"),
	preload("res://assets/lapisfin.png"),
	preload("res://assets/diamondfin.png")
]

var engine_textures = [
	preload("res://assets/steelengine.png"),
	preload("res://assets/copperengine.png"),
	preload("res://assets/ironengine.png"),
	preload("res://assets/goldengine.png"),
	preload("res://assets/zincengine.png"),
	preload("res://assets/emeraldengine.png"),
	preload("res://assets/lapisengine.png"),
	preload("res://assets/diamondengine.png")
]

var tank_textures = [
	preload("res://assets/steeltank.png"),
	preload("res://assets/coppertank.png"),
	preload("res://assets/irontank.png"),
	preload("res://assets/goldtank.png"),
	preload("res://assets/zinctank.png"),
	preload("res://assets/emeraldtank.png"),
	preload("res://assets/lapistank.png"),
	preload("res://assets/diamondtank.png")
]

var top_cone_textures = [
	preload("res://assets/steeltopcone.png"),
	preload("res://assets/coppertopcone.png"),
	preload("res://assets/irontopcone.png"),
	preload("res://assets/goldtopcone.png"),
	preload("res://assets/zinctopcone.png"),
	preload("res://assets/emeraldtopcone.png"),
	preload("res://assets/lapistopcone.png"),
	preload("res://assets/diamondtopcone.png")
]

var rocket_textures = [
	preload("res://assets/steelrocket.png"),
	preload("res://assets/copperrocket.png"),
	preload("res://assets/ironrocket.png"),
]

var original_positions := {}

func _ready() -> void:
	upgrade_plating_button.connect("pressed", Callable(self, "_on_upgrade_plating_pressed"))
	upgrade_engine_button.connect("pressed", Callable(self, "_on_upgrade_engine_pressed"))
	upgrade_fins_button.connect("pressed", Callable(self, "_on_upgrade_fins_pressed"))
	upgrade_topcone_button.connect("pressed", Callable(self, "_on_upgrade_topcone_pressed"))
	upgrade_tank_button.connect("pressed", Callable(self, "_on_upgrade_tank_pressed"))
	craft_button.connect("pressed", Callable(self, "_on_craft_pressed"))
	_update_textures()
	rocket.visible = false

func _update_textures():
	plating_1.texture = plating_textures[Global.rocket_levels["plating"]]
	plating_2.texture = plating_textures[Global.rocket_levels["plating"]]
	fins_1.texture = fins_textures[Global.rocket_levels["fins"]]
	fins_2.texture = fins_textures[Global.rocket_levels["fins"]]
	engine_1.texture = engine_textures[Global.rocket_levels["engine"]]
	tank_1.texture = tank_textures[Global.rocket_levels["tank"]]
	tank_2.texture = tank_textures[Global.rocket_levels["tank"]]
	top_cone_1.texture = top_cone_textures[Global.rocket_levels["topcone"]]

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/s1.tscn")

func _on_upgrade_plating_pressed() -> void: upgrade_part("plating")
func _on_upgrade_engine_pressed() -> void: upgrade_part("engine")
func _on_upgrade_fins_pressed() -> void: upgrade_part("fins")
func _on_upgrade_topcone_pressed() -> void: upgrade_part("topcone")
func _on_upgrade_tank_pressed() -> void: upgrade_part("tank")
func _on_craft_pressed() -> void: craft_rocket()

func upgrade_part(part_name: String):
	var level = Global.rocket_levels[part_name]
	var costs = rocket_parts[part_name]["costs"]

	if level >= costs.size():
		print(part_name, " is fully upgraded!")
		return

	var cost = costs[level]
	if can_afford(cost):
		deduct_cost(cost)
		Global.rocket_levels[part_name] += 1
		_update_textures()
		print("Upgraded ", part_name, " to level ", Global.rocket_levels[part_name])
	else:
		print("Not enough resources to upgrade ", part_name)

func can_afford(cost: Dictionary) -> bool:
	for material in cost.keys():
		if Global.get(material) < cost[material]:
			return false
	return true

func deduct_cost(cost: Dictionary):
	for material in cost.keys():
		Global.set(material, Global.get(material) - cost[material])

func craft_rocket():
	var levels = []
	for part_name in rocket_parts.keys():
		levels.append(Global.rocket_levels[part_name])

	var all_same = levels.all(func(l): return l == levels[0])
	var minimum_level = 1
	var all_minimum = levels.all(func(l): return l >= minimum_level)

	if all_same and all_minimum:
		print("Rocket crafted successfully with level: " + str(Global.rocket_levels["plating"]))
		rocket.texture = rocket_textures[Global.rocket_levels["plating"]]
		start_crafting_animation()
	else:
		print("Failed to craft - all parts must be at the same level (minimum level 1)")

func start_crafting_animation():
	var parts = [
		plating_1, plating_2,
		fins_1, fins_2,
		engine_1,
		tank_1, tank_2,
		top_cone_1
	]
	
	for p in parts:
		original_positions[p] = p.global_position

	var center = rocket.global_position
	var delay_step = 0.2
	var start_radius = 150.0
	var duration = 2.0

	for i in range(parts.size()):
		var part = parts[i]
		var angle = (TAU / parts.size()) * i
		var tween = create_tween()

		tween.tween_method(
			func(new_radius):
				var spin_angle = angle + (Time.get_ticks_msec() / 200.0)
				var pos = center + Vector2(cos(spin_angle), sin(spin_angle)) * new_radius
				part.global_position = pos, start_radius, 0.0, duration
		).set_delay(i * delay_step)

		tween.tween_callback(Callable(self, "_on_part_animation_finished").bind(part)).set_delay(i * delay_step + duration)

func _on_part_animation_finished(part: TextureRect):
	part.visible = false

	var all_invisible = true
	for p in original_positions.keys():
		if p.visible:
			all_invisible = false
			break
	
	if all_invisible:
		rocket.visible = true
		await get_tree().create_timer(1.0).timeout
		rocket.visible = false
		for part_name in rocket_parts.keys():
			Global.rocket_levels[part_name] = 0
		_update_textures()
		for p in original_positions.keys():
			p.global_position = original_positions[p]
			p.visible = true
			p.modulate.a = 1.0
		original_positions.clear()
