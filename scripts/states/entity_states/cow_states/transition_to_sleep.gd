class_name CowTransitionToSleepState
extends State

var cow: Cow

func _init(new_cow: Cow) -> void:
	cow = new_cow
	
func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("transition_to_sleep")
	cow.timer.start(0.5)
