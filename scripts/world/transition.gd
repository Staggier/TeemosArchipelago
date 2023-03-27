class_name Transition
extends AnimationPlayer

func _on_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			self.play("fade_out")
		_:
			pass
