class_name CowEatState
extends State

var cow: Cow

func _init(new_cow: Cow) -> void:
	cow = new_cow
	
func enter(enter_params: Array[Variant]) -> void:
	cow.follow_triggered = enter_params[0]
	
	cow.sprite.play("eat")
	cow.timer.start(2.5)
