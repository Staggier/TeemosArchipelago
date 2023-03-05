class_name PlayerToolState
extends State

var player

var tools: Array = ["hoe", "axe", "water"]
var tool_index = 0;

var tool: String = tools[tool_index]
	
func _physics_process(delta):
	
	if Input.is_action_pressed("t"):
		Input.action_release("t")
		player.state_machine.change_state("idle")
		return
		
	var tool_switched: bool = false
	
	if Input.is_action_pressed("next"):
		Input.action_release("next")
		tool_switched = true
		
		if tool_index == len(tools) - 1:
			tool_index = -1
		tool_index += 1
	
	if Input.is_action_pressed("previous"):
		Input.action_release("previous")
		tool_switched = true
		
		if tool_index == 0:
			tool_index = len(tools)
		tool_index -= 1
		
	if tool_switched:
		tool = tools[tool_index]
	
	match player.direction:
		Vector2.UP:
			player.sprite.animation = "%s-up" % tool
		Vector2.DOWN:
			player.sprite.animation = "%s-down" % tool
		Vector2.RIGHT:
			player.sprite.animation = "%s-right" % tool
		_:
			player.sprite.animation = "%s-left" % tool

func _init(new_player):
	player = new_player
	
