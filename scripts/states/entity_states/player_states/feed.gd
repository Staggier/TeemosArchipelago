class_name PlayerFeedState
extends State

var player: Player
var cow: Cow

func _init(new_player: Player) -> void:
	player = new_player

func enter(enter_params: Array[Variant]) -> void:
	cow = enter_params[0]
	cow.state_machine.change_state("eat", [true])
	
	player.state_machine.change_state("idle")