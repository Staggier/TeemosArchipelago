class_name PlayerFeedState
extends State

var player: Player
var cow: Cow
		
func enter(enter_params: Array[Variant]) -> void:
	cow = enter_params[0]
	cow.state_machine.change_state("eat", ["follow"])
	
	player.state_machine.change_state("idle")

func _init(new_player: Player) -> void:
	player = new_player
