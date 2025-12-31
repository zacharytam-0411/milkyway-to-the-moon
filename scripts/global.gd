extends Node

var rock1mult: float = 1
var current_interval: float
var cps: float = 0.0
var rocktier: String = "rock"
var rock: float = 0
var copper: float = 10000
var iron: float = 10000
var gold: float = 0
var zinc: float = 0
var emerald: float = 0
var lapis: float = 0
var diamond: float = 0
var coin: float = 0.0
var upgrade_level: int = 0
var button_e: bool = false

var rocket_levels = {
	"plating": 0,
	"engine": 0,
	"fins": 0,
	"topcone": 0,
	"tank": 0
}

func _rock_1click():
	match rocktier:
		"rock":
			rock += randf_range(0.1,1) * rock1mult
		"copper":
			rock += randf_range(1,2) * rock1mult
			copper += randf_range(0.1,1) * rock1mult
		"iron":
			rock += randf_range(1,3) * rock1mult
			copper += randf_range(0.5,2) * rock1mult
			iron += randf_range(0.1,1) * rock1mult
		"gold":
			rock += randf_range(2,5) * rock1mult
			copper += randf_range(1,3) * rock1mult
			iron += randf_range(0.5,2) * rock1mult
			gold += randf_range(0.1,1) * rock1mult
		"zinc":
			rock += randf_range(3,7) * rock1mult
			copper += randf_range(2,5) * rock1mult
			iron += randf_range(1,3) * rock1mult
			gold += randf_range(0.5,2) * rock1mult
			zinc += randf_range(0.1,1) * rock1mult
		"emerald":
			rock += randf_range(5,10) * rock1mult
			copper += randf_range(3,7) * rock1mult
			iron += randf_range(2,5) * rock1mult
			gold += randf_range(1,3) * rock1mult
			zinc += randf_range(0.5,2) * rock1mult
			emerald += randf_range(0.1,1) * rock1mult
		"lapis":
			rock += randf_range(10,20) * rock1mult
			copper += randf_range(5,10) * rock1mult
			iron += randf_range(3,7) * rock1mult
			gold += randf_range(2,5) * rock1mult
			zinc += randf_range(1,3) * rock1mult
			emerald += randf_range(0.5,2) * rock1mult
			lapis += randf_range(0.1,1) * rock1mult
		"diamond":
			rock += randf_range(20,50) * rock1mult
			copper += randf_range(10,20) * rock1mult
			iron += randf_range(5,10) * rock1mult
			gold += randf_range(3,7) * rock1mult
			zinc += randf_range(2,5) * rock1mult
			emerald += randf_range(1,3) * rock1mult
			lapis += randf_range(0.5,2) * rock1mult
			diamond += randf_range(0.1,1) * rock1mult
		_:
			rock += randf_range(0.1,1) * rock1mult

func f_n(num: float) -> String:
	if num >= 1_000_000_000_000_000:
		return str("%.1f" % (num / 1_000_000_000_000_000)) + "Qd"
	elif num >= 1_000_000_000_000:
		return str("%.1f" % (num / 1_000_000_000_000)) + "T"
	elif num >= 1_000_000_000:
		return str("%.1f" % (num / 1_000_000_000)) + "B"
	elif num >= 1_000_000:
		return str("%.1f" % (num / 1_000_000)) + "M"
	elif num >= 1_000:
		return str("%.1f" % (num / 1_000)) + "k"
	elif num >= 9.99:
		return str("%.1f" % num)
	else:
		return str("%.2f" % num)
