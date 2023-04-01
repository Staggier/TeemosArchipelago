class_name TreeGrowFruitState
extends State

var fruit_tree: FruitTree

func _init(new_fruit_tree: FruitTree):
	fruit_tree = new_fruit_tree

func enter(_enter_params: Array[Variant]) -> void:
	fruit_tree.fruitless = false
	fruit_tree.times_hit = 0
	
	fruit_tree.top_sprite.play("fruit_grow_" + fruit_tree.type)
	fruit_tree.bottom_sprite.play("idle")
