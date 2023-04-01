class_name PauseState
extends State

var state_machine: StateMachine
var pause_menu: PauseMenu
var water_tiles: TileMap

func _init(new_state_machine: StateMachine, new_pause_menu: PauseMenu, new_water_tiles: TileMap) -> void:
	state_machine = new_state_machine
	pause_menu = new_pause_menu
	water_tiles = new_water_tiles

func enter(enter_params: Array[Variant]) -> void:
	pause_menu.visible = true
	pause_menu.get_tree().paused = true
	
	var tiles: TileSetAtlasSource = water_tiles.get_tileset().get_source(0)
	
	# Pause water tile animation
	for i in range(0, tiles.get_tiles_count()):
		var position = tiles.get_tile_id(i)
		tiles.set_tile_animation_frame_duration(position, 0, INF)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		Input.action_release("escape")
		state_machine.change_state("play", [pause_menu])
