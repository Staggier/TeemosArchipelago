class_name PlayerRunState
extends State

var player: Player

func _physics_process(_delta):
	player.velocity = Vector2()
	
	var movement_detected: bool = false
	
	if Input.is_action_pressed("up"):
		player.velocity.y -= 1
		player.direction = Vector2.UP
		player.sprite.play("run-up")
		movement_detected = true
	if Input.is_action_pressed("down"):
		player.velocity.y += 1
		player.direction = Vector2.DOWN
		player.sprite.play("run-down")
		movement_detected = true
	if Input.is_action_pressed("left"):
		player.velocity.x -= 1
		player.direction = Vector2.LEFT
		player.sprite.play("run-left")
		movement_detected = true
	if Input.is_action_pressed("right"):
		player.velocity.x += 1
		player.direction = Vector2.RIGHT
		player.sprite.play("run-right")
		movement_detected = true
		
	# Check for movement, and switch states or restart the idler timer as necessary
	if movement_detected == false:
		player.state_machine.change_state("idle")
	else:
		player.idle_timer.start(player.IDLE_TIMEOUT)
		
	player.move()
			
func _init(new_player):
	player = new_player
	self.state_name = "run"
