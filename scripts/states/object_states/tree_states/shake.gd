class_name TreeShakeState
extends State

var fruit_tree: FruitTree

func _init(new_fruit_tree: FruitTree) -> void:
	fruit_tree = new_fruit_tree
	
func enter(enter_params: Array[Variant]) -> void:
	var player: Player = enter_params[0]
	
	fruit_tree.is_shaking = true
	
	if fruit_tree.fruitless:
		fruit_tree.top_sprite.play("shake_fruitless")
	else:
		fruit_tree.top_sprite.play("shake_" + fruit_tree.type)
		
	fruit_tree.bottom_sprite.play("idle")
	fruit_tree.timer.start(1.0)
	
	if fruit_tree.times_hit == 3:
		player.state_machine.change_state("wait", [2.35])
		fruit_tree.state_machine.change_state("fruit-fall")

	fruit_tree.times_hit += 1

func exit() -> void:
	fruit_tree.is_shaking = false
