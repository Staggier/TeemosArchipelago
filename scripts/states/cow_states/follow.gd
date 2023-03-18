class_name CowFollowState
extends State

var cow: Cow

func _physics_process(delta):
	var position
	var direction
	
	if cow.navigation_agent.is_target_reachable() and not cow.navigation_agent.is_target_reached():
		position = cow.navigation_agent.get_next_path_position()
		direction = cow.global_position.direction_to(position)
		cow.global_position += direction * delta * (cow.speed - 25)
		
	if cow.navigation_agent.is_target_reached():
		cow.sprite.play("idle")
	else:
		cow.sprite.play("run")
		
		if direction.x >= 0:
			cow.sprite.flip_h = false
		else:
			cow.sprite.flip_h = true
		
	cow.navigation_agent.target_position = cow.target.global_position
	
func _init(new_cow: Cow):
	cow = new_cow
