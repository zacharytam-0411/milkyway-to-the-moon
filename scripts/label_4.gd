extends Label

func _process(delta):
	text = "Current Auto CPS: " + (Global.f_n(1/(Global.current_interval)))
