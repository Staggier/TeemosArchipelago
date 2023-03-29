class_name Player
extends CharacterBody2D

const IDLE_TIMEOUT: int = 15

var timer: Timer
var idle_timer: Timer
var sprite: AnimatedSprite2D

enum Tool {
	HOE,
	AXE,
	WATER
}

var inside: bool = true
var passed_out: bool = false

var tools: Array[String] = ["hoe", "axe", "water"]
var tool_index: int = 0
var tool: String = tools[tool_index]
var tool_switched: bool = false

var direction: Vector2 = Vector2.DOWN
var speed: int = 115

var state_machine: StateMachine

var emote: Emote

func _init(position: Vector2 = Vector2.ZERO) -> void:
	self.position = position
	state_machine = StateMachine.new()
	
	state_machine.add_state("idle", PlayerIdleState.new(self))
	state_machine.add_state("run", PlayerRunState.new(self))
	state_machine.add_state("tool", PlayerToolState.new(self))
	state_machine.add_state("feed", PlayerFeedState.new(self))
	state_machine.add_state("pass-out", PlayerPassOutState.new(self))
	
	state_machine.current_state = state_machine.states["idle"]

func _ready() -> void:
	timer = $Timer
	idle_timer = $IdleTimer
	sprite = $Sprite
	
	sprite.play("idle-down")
	idle_timer.start(IDLE_TIMEOUT)
	
func _physics_process(delta: float) -> void:
	state_machine.current_state._physics_process(delta)
	
func move() -> void:
	self.velocity = self.velocity.normalized()
	self.velocity *= speed
	move_and_slide()	

func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"pass-out":
			state_machine.change_state("idle")
		_:
			pass

func _on_idle_timeout() -> void:
	emote.state_machine.change_state("sleepy")

func get_save_data() -> Dictionary:
	return {
		"x": self.global_position.x,
		"y": self.global_position.y,
		"state": state_machine.current_state.state_name,
		"frame": sprite.frame,
		"inside": inside,
		"tool_index": tool_index,
		"direction_x": direction.x,
		"direction_y": direction.y,
		"camera_x": $Camera.global_position.x,
		"camera_y": $Camera.global_position.y,
		"timer_wait_time": timer.time_left,
		"idle_timer_wait_time": idle_timer.time_left,
		"emote_state": emote.state_machine.current_state.state_name,
		"emote_frame": emote.sprite.frame,
		"emote_timer_wait_time": emote.timer.time_left
	}
	
func load_from_save_data(save_data: Dictionary) -> void:
	self.global_position = Vector2(save_data.x, save_data.y)
	state_machine.change_state(save_data.state)
	sprite.frame = save_data.frame
	inside = save_data.inside
	tool_index = save_data.tool_index
	direction = Vector2(save_data.direction_x, save_data.direction_y)
	$Camera.global_position = Vector2(save_data.camera_x, save_data.camera_y)
	timer.start(save_data.timer_wait_time)
	idle_timer.start(save_data.idle_timer_wait_time)
	emote.state_machine.change_state(save_data.emote_state)
	emote.sprite.frame = save_data.emote_frame
	emote.timer.start(save_data.emote_timer_wait_time)
