class_name ChickenFeedState
extends State

var chicken: Chicken

func _init(new_chicken: Chicken) -> void:
	chicken = new_chicken
	
func enter(_enter_params: Array[Variant]) -> void:
	randomize()
	
	chicken.timer.start(randi() % 3 + 3)
	chicken.sprite.play("feed")
