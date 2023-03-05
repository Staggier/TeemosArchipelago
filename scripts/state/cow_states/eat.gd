class_name CowEatState
extends State

var cow

func enter(enter_params: Array = []):
	cow.sprite.animation = "eat"
	cow.timer.wait_time = randi() % 3 + 2

func _init(new_cow):
	cow = new_cow
	self.state_name = "eat"
