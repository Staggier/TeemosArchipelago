class_name Emote
extends Control

var timer: Timer
var sprite: AnimatedSprite2D
var state_machine: StateMachine

func _on_timeout():
	match state_machine.current_state.state_name:
		"angry":
			state_machine.change_state("idle")
		_:
			pass
		
func _physics_process(delta):
	state_machine._physics_process(delta)

func _ready():
	timer = $Timer
	sprite = $AnimatedSprite2D
	sprite.play("idle")
	
func _init():
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", IdleEmoteState.new(self))
	state_machine.add_state("sleepy", SleepyEmoteState.new(self))
	state_machine.add_state("angry", AngryEmoteState.new(self))
	state_machine.add_state("happy", HappyEmoteState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]
