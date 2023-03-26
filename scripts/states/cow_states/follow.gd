class_name CowFollowState
extends State

var cow: Cow

func _physics_process(delta):
	var position
	var direction
	
	# Check if the Cow can move towards target
	if cow.navigation_agent.is_target_reachable() and not cow.navigation_agent.is_target_reached():
		position = cow.navigation_agent.get_next_path_position()
		direction = cow.global_position.direction_to(position)
		
		cow.velocity = (position - cow.global_position).normalized() * delta 
		cow.move()
		
	# Change sprite animations based on if the Cow has reached its target
	if cow.navigation_agent.is_target_reached():
		cow.sprite.play("idle")
	else:
		cow.sprite.play("run")
		
		if direction.x >= 0:
			cow.sprite.flip_h = false
		else:
			cow.sprite.flip_h = true
		
	cow.navigation_agent.target_position = cow.target.global_position

func enter(_enter_params: Array[Variant]):
	cow.timer.start(10)
	cow.speed = 75

func exit():
	cow.speed = 100

func _init(new_cow: Cow):
	cow = new_cow
	self.state_name = "follow"
