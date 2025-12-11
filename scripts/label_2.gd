extends Label

@onready var label_2: Label = $"."

func _process(delta):
	label_2.text = "Rocks: " + str(Global.rock) + "\n" + "Mult: " + str("%.2f" % Global.rock1mult)
