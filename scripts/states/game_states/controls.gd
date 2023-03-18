class_name ControlsState
extends State

var controls_menu: ControlsMenu
var state_machine: StateMachine

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		Input.action_release("escape")
		state_machine.change_state("play", [controls_menu])

func enter(_enter_params: Array[Variant]) -> void:
	controls_menu.visible = true

func _init(new_controls_menu: ControlsMenu, new_state_machine: StateMachine) -> void:
	controls_menu = new_controls_menu
	state_machine = new_state_machine
