class_name ChickenWalkState
extends State

var chicken: Chicken

func _init(new_chicken: Chicken) -> void:
	chicken = new_chicken

func enter(_enter_params: Array[Variant]) -> void:
	randomize()
	
	chicken.timer.start(randi() % 5 + 4)
	chicken.sprite.play("walk")
	
func _physics_process(delta):
	var random_direction: int = randi() % 4

	# moves up, down, left, or right with values 0-3
	match random_direction:
		0: 
			chicken.velocity.y -= 1
		1:
			chicken.velocity.y += 1
		2:
			chicken.velocity.x -= 1
			chicken.direction = Vector2.LEFT
		_:
			chicken.velocity.x += 1
			chicken.direction = Vector2.RIGHT
			
	chicken.move()
	chicken.update_face_direction()
	
