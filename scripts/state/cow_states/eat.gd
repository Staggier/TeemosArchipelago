class_name CowEatState
extends State

var cow: Cow

func enter(_enter_params):
	cow.sprite.play("eat")

func _init(new_cow):
	cow = new_cow
	self.state_name = "eat"
