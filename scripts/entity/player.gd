class_name Player
extends CharacterBody2D

const IDLE_TIMEOUT = 15

var timer: Timer
var idle_timer: Timer
var sprite: AnimatedSprite2D

enum Tool {
	HOE,
	AXE,
	WATER
}

var tools: Array = ["hoe", "axe", "water"]
var tool_index = Tool.HOE

var direction: Vector2 = Vector2.DOWN
var speed: int = 115

var state_machine: StateMachine

var emote: Emote

func _on_timeout():
	match state_machine.current_state.state_name:
		"feed":
			state_machine.change_state("idle")
		_:
			pass
			
func _on_idle_timeout():
	emote.state_machine.change_state("sleepy")

func move():
	self.velocity = self.velocity.normalized()
	self.velocity *= speed
	move_and_slide()
		
func _physics_process(delta):
	state_machine.current_state._physics_process(delta)
			
func _ready():
	timer = $Timer
	idle_timer = $IdleTimer
	sprite = $AnimatedSprite2D
	
	sprite.play("idle-down")
	idle_timer.start(IDLE_TIMEOUT)
	
func _init():
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", PlayerIdleState.new(self))
	state_machine.add_state("run", PlayerRunState.new(self))
	state_machine.add_state("tool", PlayerToolState.new(self))
	state_machine.add_state("feed", PlayerFeedState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
