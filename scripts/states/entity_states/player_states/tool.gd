class_name PlayerToolState
extends State

const NUM_TOOLS = 3
var player: Player

func _init(new_player: Player) -> void:
	player = new_player
	
func enter(_enter_params: Array[Variant]) -> void:
	# Update tool selection for sprite display
	if player.tool_switched:
		player.tool_switched = false
		player.tool = player.tools[player.tool_index]
		
		# Play an animation based on the direction the player's facing
		match player.direction:
			Vector2.UP:
				player.sprite.play("%s-up" % player.tool)
			Vector2.DOWN:
				player.sprite.play("%s-down" % player.tool)
			Vector2.RIGHT:
				player.sprite.play("%s-right" % player.tool)
			_:
				player.sprite.play("%s-left" % player.tool)
				
		match player.tool:
			"axe":
				player.timer.start(0.5)
			_:
				pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("t"):
		player.state_machine.change_state("idle")
		return
	
	# Get the next available tool
	if Input.is_action_pressed("next"):
		Input.action_release("next")
		player.tool_switched = true
		
		if player.tool_index == NUM_TOOLS - 1:
			player.tool_index = -1
		player.tool_index += 1
	
	# Get the previous available tool
	if Input.is_action_pressed("previous"):
		Input.action_release("previous")
		player.tool_switched = true
		
		if player.tool_index == 0:
			player.tool_index = NUM_TOOLS
		player.tool_index -= 1
	
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		player.state_machine.change_state("run")
		
	# Prevent the idle timer from activating
	player.idle_timer.start(player.IDLE_TIMEOUT)
