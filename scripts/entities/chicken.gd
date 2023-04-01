class_name Chicken
extends CharacterBody2D

var state_machine: StateMachine

var timer: Timer
var sprite: AnimatedSprite2D

var direction: Vector2 = Vector2.RIGHT
var speed: int = 85

var on_bridge: bool = false

func _init() -> void:
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", ChickenIdleState.new(self))
	state_machine.add_state("walk", ChickenWalkState.new(self))
	state_machine.add_state("sit", ChickenSitState.new(self))
	state_machine.add_state("transition-to-sit", ChickenTransitionToSitState.new(self))
	state_machine.add_state("transition-from-sit", ChickenTransitionFromSitState.new(self))
	state_machine.add_state("look-around", ChickenLookAroundState.new(self))
	state_machine.add_state("feed", ChickenFeedState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
	
func _ready() -> void:
	timer = $Timer
	sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	state_machine.current_state._physics_process(delta)
	
func move():
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide()

# Flip the sprite based on the direction the cow is facing and moving towards
func update_face_direction() -> void:
	if direction == Vector2.RIGHT and velocity.x >= 0:
		sprite.flip_h = false
	elif direction == Vector2.LEFT and velocity.x <= 0:
		sprite.flip_h = true
	
func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"idle":
			randomize()
			var num: int = randi() % 7
			
			if num <= 3:
				state_machine.change_state("walk")
			else:
				match num:
					4:
						state_machine.change_state("transition-to-sit")
					5:
						state_machine.change_state("look-around")
					6:
						if !on_bridge:
							state_machine.change_state("feed")
		"walk":
			state_machine.change_state("idle")
		"sit":
			state_machine.change_state("transition-from-sit")
		"feed":
			state_machine.change_state("idle")
		"look-around":
			state_machine.change_state("idle")
		"transition-to-sit":
			state_machine.change_state("sit")
		"transition-from-sit":
			state_machine.change_state("idle")
			
func get_save_data() -> Dictionary:
	return {
		"x": self.global_position.x,
		"y": self.global_position.y,
		"state": state_machine.current_state.state_name,
		"frame": sprite.frame,
		"on_bridge": on_bridge,
		"direction_x": direction.x,
		"direction_y": direction.y,
		"timer_wait_time": timer.time_left
	}
	
func load_from_save_data(save_data: Dictionary) -> void:
	self.global_position = Vector2(save_data.x, save_data.y)
	direction = Vector2(save_data.direction_x, save_data.direction_y)
	state_machine.change_state(save_data.state)
	sprite.frame = save_data.frame
	on_bridge = save_data.on_bridge
	timer.start(save_data.timer_wait_time)
