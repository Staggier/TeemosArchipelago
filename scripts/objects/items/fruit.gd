class_name Fruit
extends Item

func _init() -> void:
	self.type = ItemType.Fruit
	self.value = 5

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		self.pick_up()
