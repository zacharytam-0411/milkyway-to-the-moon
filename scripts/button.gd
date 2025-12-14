extends Button

@export var base_interval: float = 1.0
@export var base_cost: int = 10  
@export var cost_multiplier: float = 1.5  
@export var button_e: bool = false

var upgrade_level: int = 0

func _ready():
	pressed.connect(_on_button_pressed)
	update_interval()
	update_text()
	

func _on_button_pressed():
	if button_e == false:
		button_e = true
		start_click()
	var cost = get_upgrade_cost()
	if Global.rock >= cost:
		Global.rock -= cost
		upgrade_level += 1
		update_interval()
		update_text()
	else:
		print("Not enough rcoin! Need:", cost)

func update_interval():
	Global.current_interval = base_interval * pow(0.75, upgrade_level)

func get_upgrade_cost() -> int:
	return int(base_cost * pow(cost_multiplier, upgrade_level))

func update_text():
	if upgrade_level == 0:
		text = "Auto Mine (Cost: 10)"
	else:
		text = "Upgrade (Cost: " + str(Global.f_n(get_upgrade_cost())) + ")"

func start_click() -> void: 
	if button_e == true:
		await get_tree().create_timer(Global.current_interval).timeout 
		Global._rock_1click() 
		start_click()
