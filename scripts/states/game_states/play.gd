class_name PlayState
extends State

var state_machine: StateMachine

func _init(new_state_machine: StateMachine) -> void:
	state_machine = new_state_machine

func enter(enter_params: Array[Variant]) -> void:
	enter_params[0].visible = false
	enter_params[0].get_tree().paused = false
	
	var water_tiles: TileMap = enter_params[0].get_tree().get_root().get_child(0).get_child(0).get_child(1) as TileMap
	var tiles = water_tiles.get_tileset().get_source(0)
	
	# play water tile animation
	for i in range(0, tiles.get_tiles_count()):
		var position = tiles.get_tile_id(i)
		tiles.set_tile_animation_frame_duration(position, 0, 1)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		Input.action_release("escape")
		state_machine.change_state("pause")
