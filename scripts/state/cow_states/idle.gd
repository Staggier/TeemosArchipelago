class_name CowIdleState
extends State

var cow

func enter(enter_params: Array = []):
	cow.sprite.animation = "idle"
	cow.timer.wait_time = randi() % 3 + 1

func _init(new_cow):
	cow = new_cow
	self.state_name = "idle"
