class_name CowRunState
extends State

var cow: Cow

func _physics_process(_delta: float) -> void:
	var random_direction: int = randi() % 4

	# moves up, down, left, or right with values 0-3
	match random_direction:
		0: 
			cow.velocity.y -= 1
		1:
			cow.velocity.y += 1
		2:
			cow.velocity.x -= 1
			cow.direction = Vector2.LEFT
		_:
			cow.velocity.x += 1
			cow.direction = Vector2.RIGHT
			
	cow.move()
	cow.update_face_direction()
	
func enter(_enter_params: Array[Variant]) -> void:
	cow.sprite.play("run")
	cow.timer.start(2)
	
func _init(new_cow: Cow) -> void:
	cow = new_cow
	self.state_name = "run"
