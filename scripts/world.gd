class_name World
extends Node2D

var state_machine: StateMachine
var player: Player

func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _ready() -> void:
	# Set Player and Emote 
	player = $Player/CharacterBody2D as Player
	player.emote = $UI/Emote as Emote
	
	# Give the Tool Selection Menu access to the Player
	($UI/ToolSelectMenu as ToolSelectMenu).player = player
