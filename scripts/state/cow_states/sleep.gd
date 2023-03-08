class_name CowSleepState
extends State

var cow: Cow

func enter(_enter_params):
	cow.sprite.play("sleep")
	
	randomize()
	cow.timer.start(randi() % 6 + 10)

func _init(new_cow):
	cow = new_cow
	self.state_name = "sleep"
