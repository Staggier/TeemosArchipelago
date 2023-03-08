class_name HappyEmoteState
extends State

var emote: Emote

func enter(_enter_params: Array):
	emote.sprite.play("happy")

func _init(new_emote: Emote):
	emote = new_emote
	self.state_name = "happy"
