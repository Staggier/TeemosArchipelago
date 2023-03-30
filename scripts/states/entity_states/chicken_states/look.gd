class_name ChickenLookAroundState
extends State

var chicken: Chicken

func _init(new_chicken: Chicken) -> void:
	chicken = new_chicken

func enter(_enter_params: Array[Variant]) -> void:
	randomize()
	
	chicken.timer.start(randi() % 2 + 3)
	chicken.sprite.play("look-around")
