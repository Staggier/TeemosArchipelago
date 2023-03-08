class_name AngryEmoteState
extends State

var emote: Emote

func enter(_enter_params: Array):
	emote.sprite.play("angry")
	emote.timer.start(6)

func _init(new_emote):
	emote = new_emote
	self.state_name = "angry"
