class_name PlayerFeedState
extends State

var player: Player
var cow: Cow
		
func enter(enter_params: Array[Variant]) -> void:
	cow = enter_params[0]
	cow.timer.start(2.5)
	player.timer.start(0.5)
	cow.state_machine.change_state("eat")

func _init(new_player: Player) -> void:
	player = new_player
	self.state_name = "feed"
