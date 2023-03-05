class_name PlayerRunState
extends State

var player

func _physics_process(delta):
	player.velocity = Vector2()
	var movement_detected: bool = false
	
	if Input.is_action_pressed("up"):
		player.velocity.y -= 1
		player.direction = Vector2.UP
		player.sprite.animation = "run-up"
		movement_detected = true
	if Input.is_action_pressed("down"):
		player.velocity.y += 1
		player.direction = Vector2.DOWN
		player.sprite.animation = "run-down"
		movement_detected = true
	if Input.is_action_pressed("left"):
		player.velocity.x -= 1
		player.direction = Vector2.LEFT
		player.sprite.animation = "run-left"
		movement_detected = true
	if Input.is_action_pressed("right"):
		player.velocity.x += 1
		player.direction = Vector2.RIGHT
		player.sprite.animation = "run-right"
		movement_detected = true
		
	if movement_detected == false:
		player.state_machine.change_state("idle")
		
	player.move()
			
func _init(new_player):
	player = new_player
