class_name Player
extends KinematicBody2D

onready var sprite = $AnimatedSprite

var tools: Array = ["hoe", "axe", "water"]
var tool_index = 0;

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2.DOWN
var speed: int = 150

var state_machine: StateMachine

func move():
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)
		
func _physics_process(delta):
	state_machine.current_state._physics_process(delta)
			
func _ready():
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", PlayerIdleState.new(self))
	state_machine.add_state("run", PlayerRunState.new(self))
	state_machine.add_state("tool", PlayerToolState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
