class_name PlayState
extends State

var pause_menu: Control
var state_machine: StateMachine

func enter(_enter_params: Array[Variant]) -> void:
	pause_menu.visible = false
	pause_menu.get_tree().paused = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		state_machine.change_state("pause")

func _init(new_pause_menu: Control, new_state_machine: StateMachine) -> void:
	pause_menu = new_pause_menu
	state_machine = new_state_machine
