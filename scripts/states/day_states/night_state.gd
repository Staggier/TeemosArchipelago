class_name NightState
extends State

var day: Day

func _init(new_day: Day) -> void:
	day = new_day

func enter(enter_params: Array[Variant]) -> void:
	day.animation_player.play("evening_to_night")
	day.timer.start(day.NIGHT_CYCLE)
	
	var is_new_night_state: bool = enter_params[0]
	
	if day.player.inside == false and is_new_night_state:
		day.player.state_machine.change_state("pass-out")
		day.transition.play("fade_in")
