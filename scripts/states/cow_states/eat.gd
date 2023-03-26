class_name CowEatState
extends State

var cow: Cow
var follow_triggered: bool = false

func enter(enter_params: Array[Variant]) -> void:
	cow.sprite.play("eat")
	cow.timer.start(2.5)
	
	if !enter_params.is_empty():
		follow_triggered = true

func _init(new_cow: Cow) -> void:
	cow = new_cow
	self.state_name = "eat"
