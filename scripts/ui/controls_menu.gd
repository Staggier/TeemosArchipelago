class_name ControlsMenu
extends Control

var state_machine: StateMachine

func _on_back_button_pressed() -> void:
	self.visible = false
	state_machine.change_state("pause")
