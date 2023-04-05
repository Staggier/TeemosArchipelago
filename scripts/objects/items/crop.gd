class_name Crop
extends Node2D

enum CropType {
	CORN,
	CARROT,
	CAULIFLOWER,
	TOMATO,
	EGGPLANT,
	BLUE_FLOWER,
	LETTUCE,
	WHEAT,
	PUMPKIN,
	DAIKON,
	RED_FLOWER,
	TURNIP,
	STARFRUIT,
	CUCUMBER
}

var crop_scene: PackedScene
var crop_type: CropType

var is_harvestable: bool = false
var harvesting_time: int

var sprite: AnimatedSprite2D

var last_frame: int

func _ready() -> void:
	sprite = $AnimatedSprite2D

	match get_parent().get_meta("crop_type"):
		"carrot":
			crop_scene = load("res://scenes/objects/items/carrot.tscn")
			crop_type = CropType.CARROT
			harvesting_time = 60 * 6
		"corn":
			crop_scene = load("res://scenes/objects/items/corn.tscn")
			crop_type = CropType.CORN
			harvesting_time = 60 * 12
		"pumpkin":
			crop_scene = load("res://scenes/objects/items/pumpkin.tscn")
			crop_type = CropType.PUMPKIN
			harvesting_time = 60 * 24
		_:
			pass
			
	last_frame = 4 if crop_type == CropType.CORN else 3
	sprite.play("grow", 1.0 / harvesting_time)
		
func _on_animation_looped():
	is_harvestable = true
	
	sprite.pause()
	sprite.frame = last_frame
	
func drop_item():
	var crop_item: Node2D = crop_scene.instantiate()
	
	match crop_type:
		CropType.CARROT:
			crop_item.global_position = Vector2(self.global_position.x + 1.0, self.global_position.y + 1.0)
		CropType.CORN:
			crop_item.global_position = Vector2(self.global_position.x + 0.0, self.global_position.y + 7.5)
		CropType.PUMPKIN:
			crop_item.global_position = Vector2(self.global_position.x + 1.0, self.global_position.y)
			
	get_parent().get_parent().add_child(crop_item)
	queue_free()
