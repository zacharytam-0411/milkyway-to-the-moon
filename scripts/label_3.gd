extends Label

func _process(delta):
	text = str("%.2f" % Global.coin)
