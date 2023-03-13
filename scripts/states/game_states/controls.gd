class_name ControlsState
extends State

var controls_menu: ControlsMenu

func enter(_enter_params: Array[Variant]) -> void:
	controls_menu.visible = true

func _init(new_controls_menu: ControlsMenu) -> void:
	controls_menu = new_controls_menu
