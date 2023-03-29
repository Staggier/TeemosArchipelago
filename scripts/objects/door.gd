class_name Door
extends StaticBody2D

const LAST_FRAME = 4
const FIRST_FRAME = 0

var sprite: AnimatedSprite2D
var hitbox: CollisionShape2D
var timer: Timer
var closed: bool = true

func _ready() -> void:
	sprite = $Sprite
	hitbox = $Hitbox
	timer = $Timer

func _on_timeout() -> void:
	close()

func _on_sprite_animation_looped() -> void:
	sprite.stop()
	sprite.frame = LAST_FRAME if closed else FIRST_FRAME
	closed = !closed

func open() -> void:
	timer.start(1.25)
	hitbox.disabled = true
	sprite.play("open")
	
func close() -> void:
	hitbox.disabled = false
	sprite.play_backwards("open")

func toggle() -> void:
	open() if closed else close()
