class_name Emote
extends Control

var timer: Timer
var sprite: AnimatedSprite2D
var state_machine: StateMachine

func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"angry", "happy":
			state_machine.change_state("idle")
		_:
			pass
		
func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _ready() -> void:
	timer = $Timer
	sprite = $AnimatedSprite2D
	sprite.play("idle")
	
func _init() -> void:
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", IdleEmoteState.new(self))
	state_machine.add_state("sleepy", SleepyEmoteState.new(self))
	state_machine.add_state("angry", AngryEmoteState.new(self))
	state_machine.add_state("happy", HappyEmoteState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
