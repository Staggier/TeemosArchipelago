class_name CowHappyState
extends State

var cow: Cow

func enter(_enter_params: Array):
	cow.sprite.play("happy")
	cow.timer.start(randi() % 3 + 3)

func _init(new_cow):
	cow = new_cow
	self.state_name = "happy"
