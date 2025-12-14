extends Node

var rock: int
var iron: int
var coin: float
var rock1mult: float = 1
var current_interval: float

func _rock_1click():
	rock += 1*rock1mult
	coin = rock

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
