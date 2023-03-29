class_name PauseState
extends State

var pause_menu: PauseMenu
var state_machine: StateMachine

func _init(new_pause_menu: PauseMenu, new_state_machine: StateMachine) -> void:
	pause_menu = new_pause_menu
	state_machine = new_state_machine

func enter(enter_params: Array[Variant]) -> void:
	pause_menu.visible = true
	pause_menu.get_tree().paused = true
	
	var water_tiles: TileMap = pause_menu.get_tree().get_root().get_child(0).get_child(0).get_child(1) as TileMap
	var tiles: TileSetAtlasSource = water_tiles.get_tileset().get_source(0)
	
	# Pause water tile animation
	for i in range(0, tiles.get_tiles_count()):
		var position = tiles.get_tile_id(i)
		tiles.set_tile_animation_frame_duration(position, 0, INF)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		Input.action_release("escape")
		state_machine.change_state("play", [pause_menu])
