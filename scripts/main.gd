extends Node

var player: Player

var light_cow: Cow
var purple_cow: Cow
var green_cow: Cow
var pink_cow: Cow
var brown_cow: Cow

var cows: Array[Cow]

func _physics_process(_delta):
	for cow in cows:
		if player.position.y <= cow.position.y:
			cow.z_index = player.z_index
		else:
			cow.z_index = player.z_index - 1

func _ready():
	# set player and emote 
	player = $Player/CharacterBody2D
	player.emote = $Player/CanvasLayer/Control
	
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
	
	cows = [light_cow, purple_cow, green_cow, pink_cow, brown_cow]
