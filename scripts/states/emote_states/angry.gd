class_name AngryEmoteState
extends State

var emote: Emote

func enter(_enter_params: Array[Variant]) -> void:
	emote.sprite.play("angry")
	emote.timer.start(6)

func _init(new_emote: Emote) -> void:
	emote = new_emote
