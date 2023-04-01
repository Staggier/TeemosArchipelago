class_name TreeIdleState
extends State

var fruit_tree: FruitTree

func _init(new_fruit_tree: FruitTree) -> void:
	fruit_tree = new_fruit_tree
	
func enter(_enter_params: Array[Variant]) -> void:
	if fruit_tree.fruitless:
		fruit_tree.top_sprite.play("idle_fruitless")
		fruit_tree.bottom_sprite.play("idle")
	else:
		fruit_tree.top_sprite.play("idle_" + fruit_tree.type)
		fruit_tree.bottom_sprite.play("idle")
