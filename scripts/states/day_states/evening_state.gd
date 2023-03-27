class_name EveningState
extends State

var day: Day

func enter(_enter_params: Array[Variant]) -> void:
	day.animation_player.play("day_to_evening")
	day.timer.start(day.EVENING_CYCLE)
	
func _init(new_day: Day) -> void:
	day = new_day
