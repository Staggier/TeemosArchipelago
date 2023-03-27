class_name House
extends Area2D

func _init():
	pass

func _on_body_entered(body):
	if body is Player:
		body.inside = true

func _on_body_exited(body):
	if body is Player:
		body.inside = false
