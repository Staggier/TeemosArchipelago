class_name Day
extends Control

var state_machine: StateMachine
var animation_player: AnimationPlayer
var timer: Timer

var player: Player

const DAY_CYCLE: int = 60 * 12
const EVENING_CYCLE: int = 60 * 6
const NIGHT_CYCLE: int = 60 * 6

func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _ready():
	animation_player = $AnimationPlayer
	timer = $Timer
	timer.start(DAY_CYCLE)
	
func _init() -> void:
	state_machine = StateMachine.new()
	
	state_machine.add_state("day-state", DayState.new(self))
	state_machine.add_state("evening-state", EveningState.new(self))
	state_machine.add_state("night-state", NightState.new(self))
	state_machine.current_state = state_machine.states["day-state"]
	
func _on_timeout():
	match state_machine.current_state.state_name:
		"day-state":
			state_machine.change_state("evening-state")
		"evening-state":
			state_machine.change_state("night-state")
		"night-state":
			state_machine.change_state("day-state")
	
