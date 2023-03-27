class_name PlayerPassOutState
extends State

var player: Player

func enter(_enter_params: Array[Variant]) -> void:
	player.passed_out = true
	player.timer.start(2.5)
	
	match player.direction:
		Vector2.UP:
			player.sprite.play("idle-up")
		Vector2.DOWN:
			player.sprite.play("idle-down")
		Vector2.LEFT:
			player.sprite.play("idle-left")
		_:
			player.sprite.play("idle-right")
	
func exit():
	player.global_position = Vector2(-472, -15)
	player.direction = Vector2.DOWN
	player.sprite.play("idle-down")

func _init(new_player: Player) -> void:
	player = new_player
