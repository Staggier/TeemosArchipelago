class_name PlayerIdleState
extends State

var player

func _physics_process(delta):
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		player.state_machine.change_state("run")
		return
		
	if Input.is_action_pressed("t"):
		Input.action_release("t")
		player.state_machine.change_state("tool")
		return
	
func enter(enter_params: Array = []):
	match player.direction:
		Vector2.UP:
			player.sprite.animation = "idle-up"
		Vector2.DOWN:
			player.sprite.animation = "idle-down"
		Vector2.RIGHT:
			player.sprite.animation = "idle-right"
		_:
			player.sprite.animation = "idle-left"

func _init(new_player):
	player = new_player
