extends Node

var player: Player

var light_cow: Cow
var purple_cow: Cow
var green_cow: Cow
var pink_cow: Cow
var brown_cow: Cow
	
func _ready() -> void:
	# set player and emote 
	player = $Player/CharacterBody2D
	player.emote = $UI/Emote
	
	# Give the tool selection menu access to the player
	$UI/ToolSelectMenu.player = player
	
	# set cows
	light_cow = $LightCow/CharacterBody2D
	purple_cow = $PurpleCow/CharacterBody2D
	green_cow = $GreenCow/CharacterBody2D
	pink_cow = $PinkCow/CharacterBody2D
	brown_cow = $BrownCow/CharacterBody2D
	
	# set player and cow initial positions
	player.position = Vector2(0, 0)
	light_cow.position = Vector2(94, -106)
	purple_cow.position = Vector2(124, -24)
	green_cow.position = Vector2(32, 80)
	pink_cow.position = Vector2(-4, 16)
	brown_cow.position = Vector2(154, 105)
