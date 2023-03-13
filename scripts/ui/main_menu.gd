class_name MainMenu
extends Control

var game: World

# Add the world to the Game node and remove the main menu
func _on_play_button_pressed() -> void:
	get_tree().get_root().get_node("Game").add_child(game)
	get_tree().get_root().get_node("Game").remove_child(self)
