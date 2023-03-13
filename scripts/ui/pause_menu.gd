class_name PauseMenu
extends Control

var state_machine: StateMachine
var main_menu: MainMenu

func _on_about_button_pressed() -> void:
	OS.shell_open("https://staggier.github.io")

func _on_sponsor_button_pressed() -> void:
	OS.shell_open("https://github.com/sponsors/Staggier")
	
func _on_resume_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	self.visible = false
	
func _on_controls_button_pressed() -> void:
	state_machine.change_state("controls")
	self.visible = false
	
func _on_settings_button_pressed() -> void:
	pass
	
func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().get_root().get_node("Game").add_child(main_menu)
	get_tree().get_root().get_node("Game").remove_child(get_tree().get_root().get_child(0).get_child(0))
