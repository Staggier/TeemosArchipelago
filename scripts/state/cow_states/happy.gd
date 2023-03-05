class_name CowHappyState
extends State

var cow

func enter(enter_params: Array = []):
	cow.sprite.animation = "happy"
	cow.timer.wait_time = randi() % 3 + 3

func _init(new_cow):
	cow = new_cow
	self.state_name = "happy"
