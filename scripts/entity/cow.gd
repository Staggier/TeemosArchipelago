class_name Cow
extends KinematicBody2D

onready var timer: Timer = $Timer
onready var sprite: AnimatedSprite = $AnimatedSprite

var state_machine: StateMachine

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2.RIGHT
var speed: int = 100

func move():
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)
	
func update_face_direction():
	if direction == Vector2.RIGHT and velocity.x >= 0:
		sprite.flip_h = false
	elif direction == Vector2.LEFT and velocity.x <= 0:
		sprite.flip_h = true
		
func _on_idle_timeout():
	match state_machine.current_state.state_name:
		"idle":
			if randi() % 2 == 0:
				state_machine.change_state("run")
			else:
				state_machine.change_state("find")
		"run":
			state_machine.change_state("idle")
		"find":
			if randi() % 5 <= 1:
				state_machine.change_state("eat")
			else:
				state_machine.change_state("idle")
		"happy":
			state_machine.change_state("idle")
		"eat":
			state_machine.change_state("happy")
		_:
			pass
		
func _physics_process(delta):
	state_machine.current_state._physics_process(delta)
	update_face_direction()

func _ready():
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", CowIdleState.new(self))
	state_machine.add_state("run", CowRunState.new(self))
	state_machine.add_state("find", CowFindState.new(self))
	state_machine.add_state("eat", CowEatState.new(self))
	state_machine.add_state("happy", CowHappyState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
	state_machine.current_state = state_machine.states["idle"]
	state_machine.change_state("idle")
