class_name CowRunState
extends State

var cow

func _physics_process(delta):
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
	
func enter(enter_params: Array = []):
	cow.sprite.animation = "run"
	cow.timer.wait_time = 2
	
func _init(new_cow):
	cow = new_cow
	self.state_name = "run"
