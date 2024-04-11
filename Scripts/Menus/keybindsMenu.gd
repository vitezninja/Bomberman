class_name KeybindsMenu
extends Control

const MAIN_MENU_TEST = preload("res://Scenes/Menus/MainMenu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_button_pressed() -> void:
	var main = MAIN_MENU_TEST.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()