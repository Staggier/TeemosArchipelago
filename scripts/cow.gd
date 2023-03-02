class_name Cow
extends KinematicBody2D

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

func get_input():
	var random_direction: int = randi() % 4
	
	# moves up, down, left, or right with values 0-3
	match random_direction:
		0: 
			velocity.y -= 1
			direction = Vector2(0, -1)
		1:
			velocity.y += 1
			direction = Vector2(0, 1)
		2:
			velocity.x -= 1
			direction = Vector2(-1, 0)
		3:
			velocity.x += 1
			direction = Vector2(1, 0)
		_:
			print("Nothing happened")

	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 100)
	
func _physics_process(delta):
	get_input()
	get_tree().create_timer(0.5)
