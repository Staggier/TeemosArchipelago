class_name NightState
extends State

var day: Day

func enter(_enter_params: Array[Variant]) -> void:
	day.animation_player.play("evening_to_night")
	day.timer.start(day.NIGHT_CYCLE)
	
	if day.player.inside == false:
		day.player.state_machine.change_state("pass-out")
		
	
func _init(new_day: Day) -> void:
	day = new_day
