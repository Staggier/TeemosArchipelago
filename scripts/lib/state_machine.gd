class_name StateMachine
extends Node

var states: Dictionary = { }
var current_state: State

func add_state(state_name: String, state: State) -> void:
	states[state_name] = state
	
func change_state(state_name: String, enter_params: Array[Variant] = []) -> void:
	current_state.exit()
	current_state = states[state_name]
	current_state.enter(enter_params)
	
func _physics_process(delta: float) -> void:
	current_state._physics_process(delta)
