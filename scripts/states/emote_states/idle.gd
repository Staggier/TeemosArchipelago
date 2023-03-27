class_name IdleEmoteState
extends State

var emote: Emote

func enter(_enter_params: Array[Variant]) -> void:
	emote.sprite.play("idle")

func _init(new_emote: Emote) -> void:
	emote = new_emote
