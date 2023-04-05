class_name Item
extends Area2D

enum ItemType {
	FRUIT,
	CROP
}

var item_type: ItemType
var item_name: String
var item_value: int

func _ready():
	match get_parent().get_meta("item_type"):
		"fruit":
			item_type = ItemType.FRUIT
		"crop":
			item_type = ItemType.CROP
	
	item_name = get_parent().get_meta("item_name")
	item_value = int(get_parent().get_meta("item_value"))

func pick_up():
	get_parent().queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		self.pick_up()
