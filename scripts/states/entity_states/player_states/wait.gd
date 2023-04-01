class_name PlayerWaitState
extends State

var player: Player

func _init(new_player: Player) -> void:
	player = new_player

func enter(enter_params: Array[Variant]) -> void:
	var wait_time: float = enter_params[0]
	
	player.timer.start(wait_time)
	player.is_waiting = true
	
	match player.direction:
		Vector2.UP:
			player.sprite.play("idle-up")
		Vector2.DOWN:
			player.sprite.play("idle-down")
		Vector2.LEFT:
			player.sprite.play("idle-left")
		_:
			player.sprite.play("idle-right")

func exit() -> void:
	player.is_waiting = false
