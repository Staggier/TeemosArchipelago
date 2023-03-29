extends Node

var main_menu: MainMenu
var world: World

func _init() -> void:
	var state_machine = StateMachine.new()
	
	# Load World and Main Menu scenes
	world = load("res://scenes/world/world.tscn").instantiate()
	main_menu = load("res://scenes/ui/main_menu.tscn").instantiate()
	
	# Give the Main Menu access to the world
	main_menu.world = world
	
	# Give the World access to the Main Menu
	world.main_menu = main_menu

func _ready() -> void:
	add_child(main_menu)
