class_name Transition
extends AnimationPlayer

func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
			self.play("fade_out")
		_:
			get_tree().paused = false
