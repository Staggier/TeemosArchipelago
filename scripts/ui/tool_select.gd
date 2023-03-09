extends Control

var player: Player

func _process(_delta: float) -> void:
	if Input.is_action_pressed("t"):
		Input.action_release("t")
		self.visible = !self.visible
		
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		self.visible = false
		return

func _on_hoe_button_pressed() -> void:
	player.tool_index = player.Tool.HOE
	player.tool = player.tools[player.tool_index]

func _on_axe_button_pressed() -> void:
	player.tool_index = player.Tool.AXE
	player.tool = player.tools[player.tool_index]

func _on_water_button_pressed() -> void:
	player.tool_index = player.Tool.WATER
	player.tool = player.tools[player.tool_index]
