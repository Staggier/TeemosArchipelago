class_name CowFindState
extends State

var cow

func enter(enter_params: Array = []):
	cow.sprite.animation = "find"
	cow.timer.wait_time = randi() % 2 + 4

func _init(new_cow):
	cow = new_cow
	self.state_name = "find"
