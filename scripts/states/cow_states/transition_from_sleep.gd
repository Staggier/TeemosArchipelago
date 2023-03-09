class_name CowTransitionFromSleepState
extends State

var cow: Cow

func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("transition_from_sleep")
	cow.timer.start(0.4)

func _init(new_cow: Cow) -> void:
	cow = new_cow
	self.state_name = "transition_from_sleep"
