class_name SleepyEmoteState
extends State

var emote: Emote

func _init(new_emote: Emote) -> void:
	emote = new_emote

func enter(_enter_params: Array[Variant]) -> void:
	emote.sprite.play("sleepy")

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		emote.state_machine.change_state("idle")
