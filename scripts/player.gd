class_name Player
extends KinematicBody2D

enum {
	IDLE,
	RUN,
	TOOL
}

var tools: Array = ["hoe", "axe", "water"]
var tool_index = 0;

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2.DOWN
var speed: int = 150

var state = IDLE
	
func idle_state():	
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state = RUN
		return
		
	if Input.is_action_just_released("t"):
		state = TOOL
		return
	
	match direction:
		Vector2.UP:
			$AnimatedSprite.animation = "idle-up"
		Vector2.DOWN:
			$AnimatedSprite.animation = "idle-down"
		Vector2.RIGHT:
			$AnimatedSprite.animation = "idle-right"
		Vector2.LEFT:
			$AnimatedSprite.animation = "idle-left"
		_:
			pass

func run_state():
	var movement_detected: bool = false
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		$AnimatedSprite.animation = "run-up"
		movement_detected = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		$AnimatedSprite.animation = "run-down"
		movement_detected = true
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		$AnimatedSprite.animation = "run-left"
		movement_detected = true
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		$AnimatedSprite.animation = "run-right"
		movement_detected = true
			
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)
		
	if movement_detected == false:
		state = IDLE
		
func tool_state():
	if Input.is_action_just_released("t"):
		state = IDLE
		return
		
	if Input.is_action_pressed("next"):
		Input.action_release("next")
		if tool_index == len(tools) - 1:
			tool_index = -1
		tool_index += 1
	
	if Input.is_action_pressed("previous"):
		Input.action_release("previous")
		if tool_index == 0:
			tool_index = len(tools)
		tool_index -= 1
		
	var tool: String = tools[tool_index]
			
	match direction:
		Vector2.UP:
			$AnimatedSprite.animation = "%s-up" % tool
		Vector2.DOWN:
			$AnimatedSprite.animation = "%s-down" % tool
		Vector2.RIGHT:
			$AnimatedSprite.animation = "%s-right" % tool
		Vector2.LEFT:
			$AnimatedSprite.animation = "%s-left" % tool
		_:
			pass

		
func _physics_process(delta):
	velocity = Vector2()
	
	match state:
		IDLE:
			idle_state()
		RUN:
			run_state()
		TOOL:
			tool_state()
		_:
			pass
