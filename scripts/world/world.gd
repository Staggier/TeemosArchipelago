class_name World
extends Node2D

var main_menu: MainMenu
var state_machine: StateMachine

var day: Day
var transition: Transition

var player: Player
var cows: Array[Cow]
var chickens: Array[Chicken]
var trees: Array[FruitTree]

var bridges: TileMap

func _init():
	state_machine = StateMachine.new()

func _ready() -> void:
	state_machine.add_state("play", PlayState.new(state_machine))
	state_machine.add_state("pause", PauseState.new(state_machine, $CanvasLayer/PauseMenu as PauseMenu, $WaterTiles as TileMap))
	state_machine.add_state("controls", ControlsState.new($CanvasLayer/ControlsMenu as ControlsMenu, state_machine))
	state_machine.current_state = state_machine.states["play"]
	
	# Set Player and Emote 
	player = $Player/CharacterBody2D as Player
	player.emote = $CanvasLayer/Emote as Emote
	
	cows = [
		$BrownCow/CharacterBody2D as Cow,
		$GreenCow/CharacterBody2D as Cow,
		$LightCow/CharacterBody2D as Cow,
		$PinkCow/CharacterBody2D as Cow,
		$PurpleCow/CharacterBody2D as Cow
	]
	
	chickens = [
		$Chicken1/CharacterBody2D as Chicken,
		$Chicken2/CharacterBody2D as Chicken,
		$Chicken3/CharacterBody2D as Chicken
	]
	
	trees = [
		$AppleTree/StaticBody2D as FruitTree,
		$OrangeTree/StaticBody2D as FruitTree,
		$PeachTree/StaticBody2D as FruitTree,
		$PearTree/StaticBody2D as FruitTree
	]
	
	# Set Cow's target location to the Player
	for cow in cows:
		cow.target = player
		cow.navigation_agent.target_position = player.global_position
		
	# Give Menus access to the Game's state machine
	($CanvasLayer/ControlsMenu as ControlsMenu).state_machine = state_machine
	($CanvasLayer/PauseMenu as PauseMenu).state_machine = state_machine
	
	# Give Pause Menu access to Main Menu and state machine
	($CanvasLayer/PauseMenu as PauseMenu).main_menu = main_menu
	
	# Give the Tool Selection Menu access to the Player
	($CanvasLayer/ToolSelectMenu as ToolSelectMenu).player = player
	
	# Give the Day Control access to the Player
	($CanvasLayer/Day as Day).player = player
	
	# Set the color rect to be transparent to start game in 'day time'
	$CanvasLayer/Day/ColorRect.color = Color(0, 0, 0, 0)
	
	# Set Transition
	transition = $CanvasLayer/Transition/AnimationPlayer as Transition
	
	# Set Day and give it access to the Transition animation player
	day = $CanvasLayer/Day as Day
	day.transition = transition
	
	# Set bridge tiles
	bridges = $BridgeTiles
	
	load_game()
	
func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)
		
	for cow in cows:
		cow.on_bridge = on_bridge(cow)
		
	for chicken in chickens:
		chicken.on_bridge = on_bridge(chicken)

# Check if an entity is on a bridge tile
func on_bridge(entity: CharacterBody2D) -> bool:
	return bridges.get_cell_tile_data(0, bridges.local_to_map(entity.global_position)) != null
	
func save_game() -> void:
	var save_game = FileAccess.open(OS.get_executable_path().get_base_dir() + "/teemos.save", FileAccess.WRITE)
	
	# Save player state
	save_game.store_line(JSON.stringify(player.get_save_data()))
	
	# Save each cow's state
	for cow in cows:
		save_game.store_line(JSON.stringify(cow.get_save_data()))
		
	# Save each tree's state
	for tree in trees:
		save_game.store_line(JSON.stringify(tree.get_save_data()))
		
	# Save each chicken's state
	for chicken in chickens:
		save_game.store_line(JSON.stringify(chicken.get_save_data()))
		
	# Save day state
	save_game.store_line(JSON.stringify(day.get_save_data()))

func load_game() -> void:
	if not FileAccess.file_exists(OS.get_executable_path().get_base_dir() + "/teemos.save"):
		return

	var save_game = FileAccess.open(OS.get_executable_path().get_base_dir() + "/teemos.save", FileAccess.READ)
	
	# Load player's state
	player.load_from_save_data(JSON.parse_string(save_game.get_line()))
	
	# Load each cow's state
	for cow in cows:
		cow.load_from_save_data(JSON.parse_string(save_game.get_line()))
		
	# Load each tree's state
	for tree in trees:
		tree.load_from_save_data(JSON.parse_string(save_game.get_line()))
		
	# Load each chicken's state
	for chicken in chickens:
		chicken.load_from_save_data(JSON.parse_string(save_game.get_line()))
		
	# Load the day's state
	day.load_from_save_data(JSON.parse_string(save_game.get_line()))
