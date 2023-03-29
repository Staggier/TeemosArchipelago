class_name CowFindState
extends State

var cow: Cow

func _init(new_cow: Cow) -> void:
	cow = new_cow

func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("find")
	
	randomize()
	cow.timer.start(randi() % 2 + 4)
