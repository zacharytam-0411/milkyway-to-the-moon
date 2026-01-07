extends Node

var rock1mult: float = 1
var current_interval: float
var cps: float = 0.0
var rocktier: String = "rock"
var rock: float = 0
var copper: float = 0
var iron: float = 0
var gold: float = 0
var zinc: float = 0
var emerald: float = 0
var lapis: float = 0
var diamond: float = 0
var coin: float = 0.0
var upgrade_level: int = 0
var button_e: bool = false
var rocket_inventory = []
var music_volume_db: float = -10.0
var music_muted: bool = false  
var play_bgm :bool = false
var planets: float = 0
var mercury_unlocked: bool = false
var venus_unlocked: bool = false
var mars_unlocked: bool = false
var jupiter_unlocked: bool = false
var saturn_unlocked: bool = false
var uranus_unlocked: bool = false
var neptune_unlocked: bool = false
var odyssey_played: bool = false
signal earth_0
signal bgm_galaxy
signal bgm_odyssey
signal bgm_earth
signal bgm_mercury
signal bgm_venus

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
			copper += randf_range(0.1,1) * rock1mult * 0.8
		"iron":
			rock += randf_range(1,3) * rock1mult
			copper += randf_range(0.5,2) * rock1mult * 0.6
			iron += randf_range(0.1,1) * rock1mult * 0.4
		"gold":
			rock += randf_range(2,5) * rock1mult
			copper += randf_range(1,3) * rock1mult * 0.5
			iron += randf_range(0.5,2) * rock1mult * 0.35
			gold += randf_range(0.1,1) * rock1mult * 0.25
		"zinc":
			rock += randf_range(3,7) * rock1mult
			copper += randf_range(2,5) * rock1mult * 0.4
			iron += randf_range(1,3) * rock1mult * 0.3
			gold += randf_range(0.5,2) * rock1mult * 0.2
			zinc += randf_range(0.1,1) * rock1mult * 0.15
		"emerald":
			rock += randf_range(5,10) * rock1mult
			copper += randf_range(3,7) * rock1mult * 0.3
			iron += randf_range(2,5) * rock1mult * 0.25
			gold += randf_range(1,3) * rock1mult * 0.2
			zinc += randf_range(0.5,2) * rock1mult * 0.15
			emerald += randf_range(0.1,1) * rock1mult * 0.1
		"lapis":
			rock += randf_range(10,20) * rock1mult
			copper += randf_range(5,10) * rock1mult * 0.25
			iron += randf_range(3,7) * rock1mult * 0.2
			gold += randf_range(2,5) * rock1mult * 0.15
			zinc += randf_range(1,3) * rock1mult * 0.12
			emerald += randf_range(0.5,2) * rock1mult * 0.08
			lapis += randf_range(0.1,1) * rock1mult * 0.05
		"diamond":
			rock += randf_range(20,50) * rock1mult
			copper += randf_range(10,20) * rock1mult * 0.2
			iron += randf_range(5,10) * rock1mult * 0.15
			gold += randf_range(3,7) * rock1mult * 0.12
			zinc += randf_range(2,5) * rock1mult * 0.1
			emerald += randf_range(1,3) * rock1mult * 0.07
			lapis += randf_range(0.5,2) * rock1mult * 0.05
			diamond += randf_range(0.1,1) * rock1mult * 0.03
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
