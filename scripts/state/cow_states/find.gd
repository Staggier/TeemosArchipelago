class_name CowFindState
extends State

var cow: Cow

func enter(_enter_params: Array):
	cow.sprite.play("find")
	
	randomize()
	cow.timer.start(randi() % 2 + 4)

func _init(new_cow):
	cow = new_cow
	self.state_name = "find"
