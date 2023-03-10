class_name Door
extends StaticBody2D

const LAST_FRAME = 5
const FIRST_FRAME = 0

var sprite: AnimatedSprite2D
var hitbox: CollisionShape2D
var timer: Timer
var closed: bool = true

func _on_timeout():
	close()

func _on_sprite_animation_looped():
	sprite.stop()
	sprite.frame = LAST_FRAME if closed else FIRST_FRAME
	closed = !closed
	
func toggle():
	open() if closed else close()

func open():
	timer.start(1.25)
	hitbox.disabled = true
	sprite.play("open")
	
func close():
	hitbox.disabled = false
	sprite.play_backwards("open")
	
func _ready():
	sprite = $Sprite
	hitbox = $Hitbox
	timer = $Timer
