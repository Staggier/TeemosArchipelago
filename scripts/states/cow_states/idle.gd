class_name CowIdleState
extends State

var cow: Cow

func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("idle")
	
	randomize()
	cow.timer.start(randi() % 3 + 1)

func _init(new_cow: Cow) -> void:
	cow = new_cow
	self.state_name = "idle"
