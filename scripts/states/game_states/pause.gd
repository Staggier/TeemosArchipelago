class_name PauseState
extends State

var pause_menu: PauseMenu
var state_machine: StateMachine

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		state_machine.change_state("play")

func enter(enter_params: Array[Variant]) -> void:
	pause_menu.visible = true
	pause_menu.get_tree().paused = true

func _init(new_pause_menu: PauseMenu, new_state_machine: StateMachine) -> void:
	pause_menu = new_pause_menu
	state_machine = new_state_machine
