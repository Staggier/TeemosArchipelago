extends Control

func _process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		Input.action_release("escape")
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible
		
func _on_about_button_pressed() -> void:
	OS.shell_open("https://staggier.github.io")

func _on_sponsor_button_pressed() -> void:
	OS.shell_open("https://github.com/sponsors/Staggier")
	
func _on_resume_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	self.visible = false
	
func _on_settings_button_pressed() -> void:
	pass
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
