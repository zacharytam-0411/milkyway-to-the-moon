extends VBoxContainer

var sell_rates := {
	"rock": 1.0,
	"copper": 2.0,
	"iron": 5.0,
	"gold": 10.0,
	"zinc": 15.0,
	"emerald": 25.0,
	"lapis": 30.0
}

@onready var sell_10_rock: Button = $Sell10Rock
@onready var sell_10_copper: Button = $Sell10Copper
@onready var sell_10_iron: Button = $Sell10Iron
@onready var sell_10_gold: Button = $Sell10Gold
@onready var sell_10_zinc: Button = $Sell10Zinc
@onready var sell_10_emerald: Button = $Sell10Emerald
@onready var sell_10_lapis: Button = $Sell10Lapis


func _ready():
	sell_10_rock.pressed.connect(_sell_10_rock)
	sell_10_copper.pressed.connect(_sell_10_copper)
	sell_10_iron.pressed.connect(_sell_10_iron)
	sell_10_gold.pressed.connect(_sell_10_gold)
	sell_10_zinc.pressed.connect(_sell_10_zinc)
	sell_10_emerald.pressed.connect(_sell_10_emerald)
	sell_10_lapis.pressed.connect(_sell_10_lapis)


func _sell_10_rock():
	if Global.rock > 10:
		Global.coin += 10 * sell_rates["rock"]
		Global.rock -= 10

func _sell_10_copper():
	if Global.copper > 10:
		Global.coin += 10 * sell_rates["copper"]
		Global.copper -= 10

func _sell_10_iron():
	if Global.iron > 10:
		Global.coin += 10 * sell_rates["iron"]
		Global.iron -= 10

func _sell_10_gold():
	if Global.gold > 10:
		Global.coin += 10 * sell_rates["gold"]
		Global.gold -= 10

func _sell_10_zinc():
	if Global.zinc > 10:
		Global.coin += 10 * sell_rates["zinc"]
		Global.zinc -= 10

func _sell_10_emerald():
	if Global.emerald > 10:
		Global.coin += 10 * sell_rates["emerald"]
		Global.emerald -= 0

func _sell_10_lapis():
	if Global.lapis > 10:
		Global.coin += 10 * sell_rates["lapis"]
		Global.lapis -= 10
