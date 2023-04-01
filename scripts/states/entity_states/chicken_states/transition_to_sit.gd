class_name ChickenTransitionToSitState
extends State

var chicken: Chicken

func _init(new_chicken: Chicken) -> void:
	chicken = new_chicken

func enter(_enter_params: Array[Variant]) -> void:
	chicken.timer.start(0.5)
	chicken.sprite.play("transition_to_sit")
