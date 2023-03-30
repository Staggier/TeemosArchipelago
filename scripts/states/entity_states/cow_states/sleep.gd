class_name CowSleepState
extends State

var cow: Cow

func _init(new_cow: Cow) -> void:
	cow = new_cow
	
func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("sleep")
	
	randomize()
	cow.timer.start(randi() % 6 + 10)
