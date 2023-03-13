extends Node

var state_machine: StateMachine
var main_menu: MainMenu
var game: World

func _ready() -> void:
	add_child(main_menu)

func _init() -> void:
	var state_machine = StateMachine.new()
	
	# Load Game and Main Menu scenes
	game = load("res://scenes/world.tscn").instantiate()
	main_menu = load("res://scenes/ui/main_menu.tscn").instantiate()
	
	# Add Game states and set initial state
	state_machine.add_state("play", PlayState.new(game.get_child(5).get_child(3) as PauseMenu, state_machine))
	state_machine.add_state("pause", PauseState.new(game.get_child(5).get_child(3) as PauseMenu, state_machine))
	state_machine.add_state("controls", ControlsState.new(game.get_child(5).get_child(2) as ControlsMenu))
	state_machine.current_state = state_machine.states["play"]
	
	# Give Menus access to the Game's state machine
	(game.get_child(5).get_child(2) as ControlsMenu).state_machine = state_machine
	(game.get_child(5).get_child(3) as PauseMenu).state_machine = state_machine
	
	# Give Pause Menu access to Main Menu
	(game.get_child(5).get_child(3) as PauseMenu).main_menu = main_menu
	
	# Give the world access to the Game's state machine
	game.state_machine = state_machine
	
	# Give the Main Menu access to the game
	main_menu.game = game
