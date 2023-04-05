class_name PlayerHoeState
extends State

var player: Player

func _init(new_player: Player):
	player = new_player

func enter(_enter_params: Array[Variant]) -> void:
	var collider: KinematicCollision2D = player.get_last_slide_collision()
	
	if collider != null and collider.get_collider() is Crop:
		var crop = collider.get_collider() as Crop
		
		if crop.is_harvestable:
			crop.drop_item()

func _physics_process(delta):
	if !player.is_waiting and Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		player.state_machine.change_state("tool") 
	
	# Prevent the idle timer from activating
	player.idle_timer.start(player.IDLE_TIMEOUT)
