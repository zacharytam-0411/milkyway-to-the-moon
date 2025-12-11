extends Node

var rock: int
var iron: int
var coin: float
var rock1mult: float = 1

func _rock_1click():
	rock += 1*rock1mult
	coin += 0.1*rock1mult
