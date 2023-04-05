class_name PlayerFeedState
extends State

var player: Player
var cow: Cow

func _init(new_player: Player) -> void:
	player = new_player

func enter(enter_params: Array[Variant]) -> void:
	cow = enter_params[0]
	
	player.timer.start(1)
	match player.direction:
		Vector2.UP:
			player.sprite.play("feed-up")
		Vector2.DOWN:
			player.sprite.play("feed-down")
		Vector2.LEFT:
			player.sprite.play("feed-left")
		Vector2.RIGHT:
			player.sprite.play("feed-right")
