class_name MainMenu
extends Control

var world: World

# Add the world to the Game node and remove the main menu
func _on_play_button_pressed() -> void:
	get_tree().get_root().get_node("Game").add_child(world)
	get_tree().get_root().get_node("Game").remove_child(self)

# Exit game
func _on_exit_button_pressed():
	get_tree().quit()
