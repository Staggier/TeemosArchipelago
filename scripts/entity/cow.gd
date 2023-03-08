class_name Cow
extends CharacterBody2D

var timer: Timer
var sprite: AnimatedSprite2D

var state_machine: StateMachine
var pos: Vector2
var direction: Vector2 = Vector2.RIGHT
var speed: int = 100

func move():
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide()
	
func update_face_direction():
	if direction == Vector2.RIGHT and velocity.x >= 0:
		sprite.flip_h = false
	elif direction == Vector2.LEFT and velocity.x <= 0:
		sprite.flip_h = true
		
func _on_timeout():
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
			if randi() % 10 == 9:
				state_machine.change_state("happy")
			else:
				state_machine.change_state("idle")
		"happy":
			state_machine.change_state("idle")
		"eat":
			state_machine.change_state("happy")
		"sleep":
			state_machine.change_state("transition_from_sleep")
		"transition_from_sleep":
			state_machine.change_state("idle")
		"transition_to_sleep":
			state_machine.change_state("sleep")
		_:
			pass
		
func _physics_process(delta):
	state_machine.current_state._physics_process(delta)
	pos = self.position

func _ready():
	timer = $Timer
	sprite = $AnimatedSprite2D
	sprite.play("idle")
	
func _init():
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", CowIdleState.new(self))
	state_machine.add_state("run", CowRunState.new(self))
	state_machine.add_state("find", CowFindState.new(self))
	state_machine.add_state("eat", CowEatState.new(self))
	state_machine.add_state("happy", CowHappyState.new(self))
	state_machine.add_state("sleep", CowSleepState.new(self))
	state_machine.add_state("transition_from_sleep", CowTransitionFromSleepState.new(self))
	state_machine.add_state("transition_to_sleep", CowTransitionToSleepState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
