class_name CowTransitionToSleepState
extends State

var cow: Cow

func enter(_enter_params):
	cow.sprite.play("transition_to_sleep")
	cow.timer.start(0.5)

func _init(new_cow):
	cow = new_cow
	self.state_name = "transition_to_sleep"
