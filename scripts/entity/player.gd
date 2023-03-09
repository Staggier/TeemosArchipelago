class_name Player
extends CharacterBody2D

const IDLE_TIMEOUT: int = 15

var timer: Timer
var idle_timer: Timer
var sprite: AnimatedSprite2D

enum Tool {
	HOE,
	AXE,
	WATER
}

var tools: Array[String] = ["hoe", "axe", "water"]
var tool_index: int = 0
var tool: String = tools[tool_index]

var direction: Vector2 = Vector2.DOWN
var speed: int = 115

var state_machine: StateMachine

var emote: Emote

func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"feed":
			state_machine.change_state("idle")
		_:
			pass
			
func _on_idle_timeout() -> void:
	emote.state_machine.change_state("sleepy")

func move() -> void:
	self.velocity = self.velocity.normalized()
	self.velocity *= speed
	move_and_slide()
		
func _physics_process(delta: float) -> void:
	state_machine.current_state._physics_process(delta)
			
func _ready() -> void:
	timer = $Timer
	idle_timer = $IdleTimer
	sprite = $Sprite
	
	sprite.play("idle-down")
	idle_timer.start(IDLE_TIMEOUT)
	
func _init() -> void:
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", PlayerIdleState.new(self))
	state_machine.add_state("run", PlayerRunState.new(self))
	state_machine.add_state("tool", PlayerToolState.new(self))
	state_machine.add_state("feed", PlayerFeedState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
