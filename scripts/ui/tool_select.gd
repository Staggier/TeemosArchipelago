class_name ToolSelectMenu
extends Control

var player: Player

func _process(_delta: float) -> void:
	if Input.is_action_pressed("t"):
		Input.action_release("t")
		self.visible = !self.visible

func _on_hoe_button_pressed() -> void:
	player.tool_index = player.Tool.HOE
	player.tool_switched = true
	player.state_machine.change_state("tool")

func _on_axe_button_pressed() -> void:
	player.tool_index = player.Tool.AXE
	player.tool_switched = true
	player.state_machine.change_state("tool")

func _on_water_button_pressed() -> void:
	player.tool_index = player.Tool.WATER
	player.tool_switched = true
	player.state_machine.change_state("tool")
