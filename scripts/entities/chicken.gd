class_name Chicken
extends CharacterBody2D

var state_machine: StateMachine

var timer: Timer
var sprite: AnimatedSprite2D

var direction: Vector2 = Vector2.RIGHT
var speed = 85

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
