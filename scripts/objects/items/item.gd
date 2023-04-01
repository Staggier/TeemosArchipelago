class_name Item
extends Area2D

enum ItemType {
	Fruit
}

var type: ItemType
var sprite: AnimatedSprite2D

var item_name: String
var value: int
	
func pick_up():
	get_parent().queue_free()
