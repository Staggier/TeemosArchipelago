class_name PlayerRunState
extends State

var player: Player

func _init(new_player: Player) -> void:
	player = new_player

func _physics_process(_delta: float) -> void:
	player.velocity = Vector2()
	
	var horizontal_movement_detected: bool = false
	var vertical_movement_detected: bool = false
	
	# Attempt to open door
	if Input.is_action_pressed("o"):
		Input.action_release("o")
		
		var collider: KinematicCollision2D = player.get_last_slide_collision()
		if collider != null and collider.get_collider() is Door:
			(collider.get_collider() as Door).toggle()
	
	# Enter tool state
	if Input.is_action_pressed("t"):
		player.velocity = Vector2(0, 0)
		player.state_machine.change_state("tool")
		return
		
	# Check for horizontal movement
	if Input.is_action_pressed("left"):
		player.velocity.x = -1
		player.direction = Vector2.LEFT
		player.sprite.play("run-left")
		horizontal_movement_detected = true
	elif Input.is_action_pressed("right"):
		player.velocity.x = 1
		player.direction = Vector2.RIGHT
		player.sprite.play("run-right")
		horizontal_movement_detected = true
	
	# Check for vertical movement
	if Input.is_action_pressed("up"):
		player.velocity.y = -1
		if !horizontal_movement_detected:
			player.sprite.play("run-up")
		player.direction = Vector2.UP
		vertical_movement_detected = true
	elif Input.is_action_pressed("down"):
		player.velocity.y = 1
		if !horizontal_movement_detected:
			player.sprite.play("run-down")
		player.direction = Vector2.DOWN
		vertical_movement_detected = true
		
	# Check for detected movement, and switch states or restart the idle timer as necessary
	if !horizontal_movement_detected and !vertical_movement_detected:
		player.state_machine.change_state("idle")
	else:
		player.idle_timer.start(player.IDLE_TIMEOUT)
		
	player.move()
