class_name SleepyEmoteState
extends State

var emote: Emote

func _physics_process(_delta):
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		emote.state_machine.change_state("idle")

func enter(_enter_params: Array):
	emote.sprite.play("sleepy")

func _init(new_emote: Emote):
	emote = new_emote
	self.state_name = "sleepy"
