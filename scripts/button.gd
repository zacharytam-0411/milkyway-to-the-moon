extends Button
@export var interval: int = 1

func _ready():
	start_click()

func start_click() -> void:
	await get_tree().create_timer(interval).timeout
	Global._rock_1click()
	start_click()  # call again to repeat
