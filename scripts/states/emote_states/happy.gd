class_name HappyEmoteState
extends State

var emote: Emote

func _init(new_emote: Emote) -> void:
	emote = new_emote

func enter(_enter_params: Array[Variant]) -> void:
	emote.sprite.play("happy")
	emote.timer.start(6)
