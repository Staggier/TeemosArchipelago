class_name IdleEmoteState
extends State

var emote: Emote

func enter(_enter_params: Array):
	emote.sprite.play("idle")

func _init(new_emote: Emote):
	emote = new_emote
	self.state_name = "idle"
