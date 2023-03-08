class_name CowTransitionFromSleepState
extends State

var cow: Cow

func enter(_enter_params):
	cow.sprite.play("transition_from_sleep")
	cow.timer.start(0.4)

func _init(new_cow):
	cow = new_cow
	self.state_name = "transition_from_sleep"
