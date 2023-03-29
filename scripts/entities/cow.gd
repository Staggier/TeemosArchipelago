class_name Cow
extends CharacterBody2D

var timer: Timer
var sprite: AnimatedSprite2D

var target: Player
var navigation_agent: NavigationAgent2D

var state_machine: StateMachine
var direction: Vector2 = Vector2.RIGHT
var speed: int = 100

var on_bridge: bool = false

func _init() -> void:
	state_machine = StateMachine.new()
	self.position = Vector2(0, 0)
	
	state_machine.add_state("idle", CowIdleState.new(self))
	state_machine.add_state("run", CowRunState.new(self))
	state_machine.add_state("find", CowFindState.new(self))
	state_machine.add_state("eat", CowEatState.new(self))
	state_machine.add_state("happy", CowHappyState.new(self))
	state_machine.add_state("sleep", CowSleepState.new(self))
	state_machine.add_state("transition_from_sleep", CowTransitionFromSleepState.new(self))
	state_machine.add_state("transition_to_sleep", CowTransitionToSleepState.new(self))
	state_machine.add_state("follow", CowFollowState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
	
func _ready() -> void:
	timer = $Timer
	navigation_agent = $NavigationAgent2D
	sprite = $AnimatedSprite2D
	sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	state_machine.current_state._physics_process(delta)

func move() -> void:
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
			var random: int = randi() % 3
			match random:
				0:
					state_machine.change_state("run")
				1:
					state_machine.change_state("find")
				2:
					state_machine.change_state("transition_to_sleep")
		"run":
			state_machine.change_state("idle")
		"find":
			randomize()
			if randi() % 10 == 9 and !on_bridge:
				state_machine.change_state("eat")
			else:
				state_machine.change_state("idle")
		"happy":
			state_machine.change_state("idle")
		"eat":
			if (state_machine.current_state as CowEatState).follow_triggered:
				state_machine.change_state("follow")
			else:	
				state_machine.change_state("happy")
		"sleep":
			state_machine.change_state("transition_from_sleep")
		"transition_from_sleep":
			state_machine.change_state("idle")
		"transition_to_sleep":
			state_machine.change_state("sleep")
		"follow":
			state_machine.change_state("idle")
		_:
			pass

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
