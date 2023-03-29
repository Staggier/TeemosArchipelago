class_name House
extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.inside = true

func _on_body_exited(body: CharacterBody2D) -> void:
	if body is Player:
		body.inside = false
