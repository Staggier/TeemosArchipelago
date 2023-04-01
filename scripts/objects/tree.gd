class_name FruitTree
extends StaticBody2D

var state_machine: StateMachine
var timer: Timer
var regrow_timer: Timer

var top_sprite: AnimatedSprite2D
var bottom_sprite: AnimatedSprite2D

var fruit_scene: PackedScene

var fruitless: bool = false
var is_shaking: bool = false

var type: String
var times_hit: int = 0


func _init() -> void:
	state_machine = StateMachine.new()
	state_machine.add_state("idle", TreeIdleState.new(self))
	state_machine.add_state("shake", TreeShakeState.new(self))
	state_machine.add_state("fruit-fall", TreeFruitFallState.new(self))
	state_machine.add_state("fruit-grow", TreeGrowFruitState.new(self))
	state_machine.current_state = state_machine.states["idle"]
	
func _ready() -> void:
	timer = $Timer
	regrow_timer = $RegrowTimer
	
	top_sprite = $TreeSprite
	bottom_sprite = $TrunkSprite
	
	type = get_parent().get_meta("FruitType")
	match type:
		"apple":
			fruit_scene = load("res://scenes/objects/items/apple.tscn")
		"orange":
			fruit_scene = load("res://scenes/objects/items/orange.tscn")
		"peach":
			fruit_scene = load("res://scenes/objects/items/peach.tscn")
		"pear":
			fruit_scene = load("res://scenes/objects/items/pear.tscn")
	pass
	
	state_machine.change_state("idle")

func _physics_process(delta: float) -> void:
	state_machine._physics_process(delta)

func _on_timeout() -> void:
	match state_machine.current_state.state_name:
		"shake":
			state_machine.change_state("idle")
		_:
			pass
			
func _on_regrow_timeout() -> void:
	if !is_shaking:
		state_machine.change_state("fruit-grow")
	else:
		regrow_timer.start(2.0)

func _on_top_animation_looped():
	match state_machine.current_state.state_name:
		"fruit-fall":
			var fruit1 = fruit_scene.instantiate()
			var fruit2 = fruit_scene.instantiate()
			var fruit3 = fruit_scene.instantiate()

			# Set the position of each of the three fruit depending on the type of tree its coming from
			match type:
				"apple":
					fruit1.global_position = Vector2(self.global_position.x - 19, self.global_position.y + 9.5)
					fruit2.global_position = Vector2(self.global_position.x + 20, self.global_position.y + 5.5)
					fruit3.global_position = Vector2(self.global_position.x + 17, self.global_position.y + 13.5)
				"orange":
					fruit1.global_position = Vector2(self.global_position.x - 19, self.global_position.y + 9.5)
					fruit2.global_position = Vector2(self.global_position.x - 16, self.global_position.y + 18.5)
					fruit3.global_position = Vector2(self.global_position.x + 17, self.global_position.y + 14.5)
				"peach":
					fruit1.global_position = Vector2(self.global_position.x - 18.5, self.global_position.y + 9.5)
					fruit2.global_position = Vector2(self.global_position.x - 15.5, self.global_position.y + 18.5)
					fruit3.global_position = Vector2(self.global_position.x + 16.5, self.global_position.y + 14.5)
				"pear":
					fruit1.global_position = Vector2(self.global_position.x - 19.5, self.global_position.y + 8)
					fruit2.global_position = Vector2(self.global_position.x - 17.5, self.global_position.y + 18)
					fruit3.global_position = Vector2(self.global_position.x + 16.5, self.global_position.y + 15)
					
			# Add each fruit to the game world
			get_parent().get_parent().add_child(fruit1)
			get_parent().get_parent().add_child(fruit2)
			get_parent().get_parent().add_child(fruit3)
			
			# Set tree back to default state
			fruitless = true
			state_machine.change_state("idle")
			
		"fruit-grow":
			state_machine.change_state("idle")
		_:
			pass

func get_save_data() -> Dictionary:
	return {
		"state": state_machine.current_state.state_name,
		"top_frame": top_sprite.frame,
		"bottom_frame": bottom_sprite.frame,
		"times_hit": times_hit,
		"timer_wait_time": timer.time_left,
		"regrow_timer_wait_time": regrow_timer.time_left,
		"fruitless": fruitless,
		"is_shaking": is_shaking
	}
	
func load_from_save_data(save_data: Dictionary) -> void:
	top_sprite.frame = save_data.top_frame
	bottom_sprite.frame = save_data.bottom_frame
	times_hit = save_data.times_hit
	fruitless = save_data.fruitless
	is_shaking = save_data.is_shaking
	
	state_machine.change_state(save_data.state)
	timer.start(save_data.timer_wait_time)
	
	if save_data.regrow_timer_wait_time != 0:
		regrow_timer.start(save_data.regrow_timer_wait_time)
