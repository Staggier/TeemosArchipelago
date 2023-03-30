class_name Day
extends Control

var state_machine: StateMachine
var animation_player: AnimationPlayer
var color_rect: ColorRect
var timer: Timer

var player: Player

const DAY_CYCLE: int = 60 * 12
const EVENING_CYCLE: int = 60 * 6
const NIGHT_CYCLE: int = 60 * 6

func _init() -> void:
	state_machine = StateMachine.new()
	
	state_machine.add_state("day-state", DayState.new(self))
	state_machine.add_state("evening-state", EveningState.new(self))
	state_machine.add_state("night-state", NightState.new(self))
	state_machine.current_state = state_machine.states["day-state"]
	
func _ready() -> void:
	animation_player = $AnimationPlayer
	color_rect = $ColorRect
	timer = $Timer
	timer.start(DAY_CYCLE)
	
func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"day-state":
			state_machine.change_state("evening-state")
		"evening-state":
			state_machine.change_state("night-state")
		"night-state":
			state_machine.change_state("day-state")
	
func get_save_data() -> Dictionary:
	return {
		"state": state_machine.current_state.state_name,
		"color": color_rect.color,
		"animation_player_current_animation": animation_player.current_animation,
		"animation_player_current_animation_position": animation_player.current_animation_position,
		"timer_wait_time": timer.time_left
	}
	
func load_from_save_data(save_data: Dictionary) -> void:
	state_machine.change_state(save_data.state)

	if save_data.animation_player_current_animation != "":
		animation_player.current_animation = save_data.animation_player_current_animation
		animation_player.advance(save_data.animation_player_current_animation_position)
	else:
		match save_data.state:
			"day-state":
				animation_player.current_animation = "night_to_day"
				animation_player.advance(2.9)
			"evening-state":
				animation_player.current_animation = "day_to_evening"
				animation_player.advance(2.9)
			"night-state":
				animation_player.current_animation = "evening-to-night"
				animation_player.advance(2.9)

	color_rect.color = save_data.color
	timer.start(save_data.timer_wait_time)
