class_name Cow
extends KinematicBody2D

enum {
	IDLE,
	RUN,
	SLEEP,
	FIND,
	EAT,
	HAPPY
}

onready var timer = $Timer
onready var sprite: AnimatedSprite = $AnimatedSprite

var states = ["idle", "run", "sleep", "find", "eat", "happy"]
var state = IDLE

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2.RIGHT
var speed: int = 100

func idle_state():
	sprite.animation = "idle"
				
func run_state():
	var random_direction: int = randi() % 4
	sprite.animation = "run"

	# moves up, down, left, or right with values 0-3
	match random_direction:
		0: 
			velocity.y -= 1
		1:
			velocity.y += 1
		2:
			velocity.x -= 1
			direction = Vector2.LEFT
		3:
			velocity.x += 1
			direction = Vector2.RIGHT
		_:
			print("Nothing happened")

	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)

func _physics_process(delta):
	match state:
		IDLE:
			idle_state()
		RUN:
			run_state()
		_:
			pass
				
	update_face_direction()
	get_tree().create_timer(1)
	
func update_face_direction():
	if direction == Vector2.RIGHT and velocity.x >= 0:
		sprite.flip_h = false
	elif direction == Vector2.LEFT and velocity.x <= 0:
		sprite.flip_h = true

func _on_idle_timeout():
	state = randi() % 2
	
func _ready():
	timer.set_wait_time(2)
	timer.start()
