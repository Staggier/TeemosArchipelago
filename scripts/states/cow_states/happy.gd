class_name CowHappyState
extends State

var cow: Cow

func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("happy")
	cow.timer.start(randi() % 3 + 3)

func _init(new_cow: Cow) -> void:
	cow = new_cow
	self.state_name = "happy"
