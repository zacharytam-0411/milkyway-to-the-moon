extends Label
@onready var display_1: Label = $"."

func _process(delta):
	text = \
	"R: "    + str(Global.f_n(Global.rock))    + "\n" + \
	"C: "  + str(Global.f_n(Global.copper))  + "\n" + \
	"I: "    + str(Global.f_n(Global.iron))    + "\n" + \
	"G: "    + str(Global.f_n(Global.gold))    + "\n" + \
	"Z: "    + str(Global.f_n(Global.zinc))    + "\n" + \
	"E: " + str(Global.f_n(Global.emerald)) + "\n" + \
	"L: "   + str(Global.f_n(Global.lapis))
