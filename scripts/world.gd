class_name World
extends Node2D

var state_machine: StateMachine
var player: Player

var cows: Array[Cow]

func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _ready() -> void:
	# Set Player and Emote 
	player = $Player/CharacterBody2D as Player
	player.emote = $UI/Emote as Emote
	
	cows = [
		$BrownCow/CharacterBody2D as Cow,
		$GreenCow/CharacterBody2D as Cow,
		$LightCow/CharacterBody2D as Cow,
		$PinkCow/CharacterBody2D as Cow,
		$PurpleCow/CharacterBody2D as Cow
	]
	
	# Set Cow's target location to the Player
	for cow in cows:
		cow.target = player
		cow.navigation_agent.target_position = player.global_position
	
	# Give the Tool Selection Menu access to the Player
	($UI/ToolSelectMenu as ToolSelectMenu).player = player
