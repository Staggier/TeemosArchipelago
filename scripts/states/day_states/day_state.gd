class_name DayState
extends State

var day: Day

func _init(new_day: Day) -> void:
	day = new_day

func enter(_enter_params: Array[Variant]) -> void:
	day.animation_player.play("night_to_day")
	day.timer.start(day.DAY_CYCLE)
