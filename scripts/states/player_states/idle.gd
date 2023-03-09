class_name PlayerIdleState
extends State

var player: Player

func _physics_process(_delta: float) -> void:
	# Player moved
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		player.state_machine.change_state("run")
		return
		
	# Tool state
	if Input.is_action_pressed("t"):
		player.state_machine.change_state("tool")
		return
		
	# Attempt to feed Cow
	if Input.is_action_pressed("f"):
		Input.action_release("f")
		
		var collider: KinematicCollision2D = player.get_last_slide_collision()
		if collider != null and collider.get_collider() is Cow:
			randomize()
			if randi() % 4 != 3:	
				player.state_machine.change_state("feed", [collider.get_collider()])
				player.emote.state_machine.change_state("happy")
			else:
				(collider.get_collider() as Cow).state_machine.change_state("run")
				player.emote.state_machine.change_state("angry")
			return
	
func enter(_enter_params: Array[Variant]) -> void:
	match player.direction:
		Vector2.UP:
			player.sprite.play("idle-up")
		Vector2.DOWN:
			player.sprite.play("idle-down")
		Vector2.RIGHT:
			player.sprite.play("idle-right")
		_:
			player.sprite.play("idle-left")

func _init(new_player: Player) -> void:
	player = new_player
	self.state_name = "idle"
