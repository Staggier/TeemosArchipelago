class_name TreeFruitFallState
extends State

var fruit_tree: FruitTree

func _init(new_fruit_tree):
	fruit_tree = new_fruit_tree

func enter(_enter_params: Array[Variant]) -> void:
	fruit_tree.fruitless = true
	
	fruit_tree.timer.start(1.0)
	fruit_tree.regrow_timer.start(60 * 6)
	
	fruit_tree.top_sprite.play("fruit_fall_" + fruit_tree.type)
	fruit_tree.bottom_sprite.play("fruit_fall_" + fruit_tree.type)
