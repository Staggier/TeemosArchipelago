extends KinematicBody2D

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		$AnimatedSprite.animation = "idle-up"
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		$AnimatedSprite.animation = "idle-down"
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		$AnimatedSprite.animation = "idle-left"
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		$AnimatedSprite.animation = "idle-right"
	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 150)
		
func _physics_process(delta):
	read_input()
