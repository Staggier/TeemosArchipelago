class_name CowHappyState
extends State

var cow: Cow

func _init(new_cow: Cow) -> void:
	cow = new_cow
	
func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("happy")
	
	randomize()
	cow.timer.start(randi() % 3 + 3)
